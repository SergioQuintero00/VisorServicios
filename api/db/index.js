const express = require("express");
const { Pool } = require("pg");
const cors = require("cors");
const path = require("path");
const dotenv = require('dotenv');
const result = dotenv.config();

//IMPRESIÓN CARGA Y DATOS DEL .ENV
// if (result.error) {
//   console.log('Error cargando el archivo .env', result.error);
// } else {
//   console.log('Archivo .env cargado correctamente');
// }

// console.log(process.env.PG_USER);
// console.log(process.env.PG_PASSWORD);
// console.log(process.env.PG_DATABASE);
// console.log(process.env.PG_HOST);
// console.log(process.env.PG_PORT);

const pool = new Pool({
  user: process.env.PG_USER,
  host: process.env.PG_HOST,
  database: process.env.PG_DATABASE,
  password: process.env.PG_PASSWORD,
  port: process.env.PG_PORT,
});

//PRUEBA DE CONEXIÓN
// pool.connect()
//   .then(client => {
//     console.log("Conexión exitosa a la base de datos");
//     client.release();
//   })
//   .catch(err => {
//     console.error('Error al conectar con la base de datos:', err);
//   });

module.exports = pool;