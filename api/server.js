const express = require('express');
const app = express();
const cors = require('cors');
require('dotenv').config();

app.use(cors()); //Para no permitir peticiones desde otro origen (es decir que no sea del 3000)
app.use(express.json()); // Para JSON en el body

const serviciosRoutes = require('./routes/servicios'); //dos lineas para poder usar servicios.js
app.use('/api', serviciosRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Servidor corriendo en http://0.0.0.0:${PORT}`);
});