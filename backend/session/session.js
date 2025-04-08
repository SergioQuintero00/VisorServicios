
function validaInicio() {

  const dni = document.getElementById("dni");
  const password = document.getElementById("password");

  let esValido = true;

  // Validar el campo "dni"
  if (!(/^\d{8}[a-zA-Z]$/).test(dni.value)) {
    alert("DNI inválido")
    esValido = false;
    return null;
  }

  // Validar el campo "DNI"
  if (!(/^.{1,30}$/).test(password.value)) {
    alert("Introduzca una contraseña")
    esValido = false;
    return null;
  }

  if (esValido == true) {
    login();
  }
}

function login() {
  // Capturar los valores del formulario
  var dni = document.getElementById('dni').value;
  var password = document.getElementById('password').value;

  // Crear la petición AJAX
  fetch(`http://localhost:3000/api/login`, { //CONSULTA
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      dni: dni,
      password: password
    })
  })
    .then(response => response.json())
    .then(data => { //DATOS
      if (data.success) {
        //Guarda los datos del usuario en la sesión
        sessionStorage.setItem('cliente', JSON.stringify(data.client));

        //redirije a la página principal
        window.location.href = `menu.html`;
      } else {
        alert(data.error);
      }
    })
    .catch(error => {
      console.error("Error durante el login:", error);
    });
}