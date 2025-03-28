const express = require('express');
const router = express.Router();
const pool = require('../db/index');
const bcrypt = require("bcrypt");


// 1. Obtener todos los servicios de un cliente (usuario) ordenados por Fecha_Entrada DESC
router.get('/servicios/usuario/:usuarioId', async (req, res) => {
  const { usuarioId } = req.params;
  try {
    const result = await pool.query(`
      SELECT s.id, s.idCliente, s.asunto, s.estado, s.detalles, s."ObservacionTec", s."Fecha_Entrada", 
      s."Fecha_Salida", s."Fecha_Creacion", s."TipoServicio"
      FROM Servicio s
      WHERE s.idCliente = $1
      ORDER BY s."Fecha_Entrada" DESC
    `, [usuarioId]);

    res.json(result.rows);
  } catch (err) {
    console.error('Error al obtener servicios del usuario:', err);
    res.status(500).json({ error: 'Error al obtener servicios del usuario' });
  }
});


// 2. Obtener historial de un servicio ordenado por Fechayhora ASC
router.get('/historial/:servicioId', async (req, res) => {
  const { servicioId } = req.params;
  try {
    const result = await pool.query(`
      SELECT h.id, h."IDServicio", h."Detalle", h."Fechayhora"
      FROM "Serv_Historial" h
      WHERE h."IDServicio" = $1
      ORDER BY h."Fechayhora" ASC
    `, [servicioId]);

    res.json(result.rows);
  } catch (err) {
    console.error('Error al obtener historial del servicio:', err);
    res.status(500).json({ error: 'Error al obtener historial del servicio' });
  }
});


// 3. Obtener datos de un servicio por ID
router.get('/servicio/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(`
      SELECT s.id, s.idCliente, s.asunto, s.estado, s.detalles, s."ObservacionTec", s."Fecha_Entrada", 
      s."Fecha_Salida", s."Fecha_Creacion", s."TipoServicio", c.nombre AS cliente_nombre, c.dni AS cliente_dni,
      c.telefono AS cliente_telefono
      FROM servicio s
      JOIN Cliente c ON s.idCliente = c.id
      WHERE s.id = $1
    `, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Servicio no encontrado' });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error('Error al obtener servicio por ID:', err);
    res.status(500).json({ error: 'Error al obtener servicio por ID' });
  }
});


// 4. Obtener datos de un cliente por dni
router.post('/login', async (req, res) => {
  const { dni, password } = req.body;
  try {
    const result = await pool.query(`
      SELECT id, nombre, contraseña, dni, telefono 
      FROM Cliente 
      WHERE dni = $1
    `, [dni]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Cliente no encontrado' });
    }

    const clientData = result.rows[0];

    // Comparar la contraseña en texto plano con el hash de la base de datos
    const passwordMatch = await bcrypt.compare(password, clientData.contraseña);

    if (passwordMatch) {
      // La contraseña es correcta, se puede generar un token o establecer una sesión.
      // Por ejemplo, se puede devolver los datos del cliente (sin la contraseña)
      const { password, ...clientWithoutPassword } = clientData; //quita la contraseña de clientData con el operador ... (rest)
      res.json({
        success: true,
        client: clientWithoutPassword
      });
    } else {
      res.status(401).json({ error: "Contraseña incorrecta" });
    }
  } catch (err) {
    console.error('Error al obtener cliente por DNI:', err);
    res.status(500).json({ error: 'Error al obtener cliente por DNI' });
  }
});

module.exports = router;
