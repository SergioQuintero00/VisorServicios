document.addEventListener("DOMContentLoaded", function () {
  let urlParams = new URLSearchParams(window.location.search);
  const idServicio = urlParams.get('id');
  console.log("ID obtenido de la URL:", idServicio);

  if (idServicio) {
    getDatosServicio(idServicio);
    getHistorialServicio(idServicio);
  } else {
    console.error("No se encontró el parámetro 'id' en la URL.");
  }
});

//Hace la consulta a la base de datos sobre los datos del Servicio
function getDatosServicio(idServicio) {
  fetch(`http://192.168.1.145:3000/api/servicio/${idServicio}`)
  .then(response => {
    if (!response.ok) {
      throw new Error("Servicio no encontrado");
    }
    return response.json();
  })
  .then(data => {
    setDatosServicio(data);
  })
  .catch(error => console.error("Error al obtener servicio por ID:", error));
}

function getHistorialServicio(idServicio) {
  fetch(`http://192.168.1.145:3000/api/historial/${idServicio}`)
  .then(response => response.json())
  .then(data => {
    setDatosHistorial(data);
  })
  .catch(error => console.error("Error al obtener historial del servicio:", error));
}

//Este método inserta los datos en el html o inserta html en la página sobre los datos del servicio
function setDatosServicio(datos) {
  const idServicio = datos.id;
  const idCliente = datos.idCliente;
  const asunto = datos.servicio;
  const detalles = datos.detalles;
  const memoTecnico = datos.memoTecnico;
  const Fecha_Entrada = datos.fecha_Entrada;
  const Fecha_Salida = datos.fecha_Salida;
  const Fecha_Creacion = datos.fecha_Creacion;
  const estado = datos.Estado;
  const contactar = datos.contactar; //true o false
  const prioridad = datos.prioridad; //del 1 al 5, 5 más importante
  const tipoServicio = datos.TipoServicio;
  const cliente_nombre = datos.cliente_nombre;
  const cliente_dni = datos.cliente_dni;
  const cliente_telefono = datos.cliente_telefono;

  document.getElementById("asuntoId").innerHTML = asunto + " #" + idServicio;
  document.getElementById("fechaEntrada").innerHTML = Fecha_Entrada;
  document.getElementById("fechaSalida").innerHTML = Fecha_Salida;
  document.getElementById("estado").innerHTML = estado;
  document.getElementById("tipoServicio").innerHTML = tipoServicio;
  document.getElementById("observaciones").innerHTML = memoTecnico;
  document.getElementById("idServicio").innerHTML = idServicio;

}


//Este método inserta los datos en el html o inserta html en la página sobre el historial del servicio
function setDatosHistorial(historial) {
  const timelineContainer = document.querySelector('.timeline');
  let html = "";
  let numeroEvento = 1;
  historial.forEach(item => {
    // Extrae los datos del historial
    const idHistorial = item.id;
    const idServicio = item.idServicio;
    const detalle = item.detalle;
    const fechayhora = item.fechayhora;

    // Crea un bloque HTML para cada evento del historial
    html += `
      <div class="timeline-item">
        <br>
        <h5>Evento ${numeroEvento}</h5>
        <small class="text-muted">${fechayhora}</small>
        <p class="mt-2">${detalle}</p>
      </div>
    `;
    numeroEvento = numeroEvento + 1;
  });

  // Inserta el HTML generado en el contenedor de la línea de tiempo
  timelineContainer.innerHTML = html;
}
