const express = require('express');
const router = express.Router();
const pool = require('../db/index');
const bcrypt = require("bcrypt");


// 1. Obtener todos los servicios de un cliente (usuario) ordenados por Fecha_Entrada DESC
router.get('/servicios/usuario/:usuarioId', async (req, res) => {
  const { usuarioId } = req.params;
  try {
    const result = await pool.query(`
      SELECT s.id, s.idCliente, s.servicio, s.detalles, s."memoTecnico", s."fecha_Entrada", s."fecha_Salida", 
      s."fecha_Creacion", e."Estado", s.contactar, s.prioridad, t."TipoServicio"
      FROM "Servicio" s
      JOIN "EstadoServicio" e ON s."idEstado" = e.id
      JOIN "TipoServicio" t ON s."idTipoServicio" = t.id
      WHERE s.idCliente = $1
      ORDER BY s."fecha_Entrada" DESC
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
      SELECT h.id, h."idServicio", h.detalle, h.fechayhora
      FROM "Serv_Historial" h
      WHERE h."idServicio" = $1
      ORDER BY h.fechayhora ASC
    `, [servicioId]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Servicio no encontrado' });
    }

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
      SELECT s.id, s.idCliente, s.servicio, s.detalles, s."memoTecnico", s."fecha_Entrada", s."fecha_Salida", 
      s."fecha_Creacion", e."Estado", s.contactar, s.prioridad, t."TipoServicio", en.nombre AS cliente_nombre, en.dni AS cliente_dni,
      en.telefono AS cliente_telefono
      FROM "Servicio" s
      JOIN "EstadoServicio" e ON s."idEstado" = e.id
      JOIN "TipoServicio" t ON s."idTipoServicio" = t.id
      JOIN "Entidad" en ON s.idCliente = en.id
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
      FROM "Entidad" 
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
