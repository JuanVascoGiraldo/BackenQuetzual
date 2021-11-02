function aceptar() {
    document.getElementById('enviar').submit;
    registrarr();
}

function modC() {
    document.getElementById('modificar').submit;
    modificarcuenta();
}

function modP() {
    document.getElementById('modPassword').submit;
    modificarContra();
}


function validarIS() {
    document.getElementById('IniciarSesion').submit;
    var correo = document.getElementById('IScorreo').value;
    var contra = document.getElementById('IScontra').value;
    if (validarcorreo(correo) && validarcontrasena(contra)) {
        Swal.fire(
            '¡Bienvenido!',
            '¡Los datos coinciden!',
            'success'
        )
        setTimeout(function() {
            distribucion();
            //location.href=´direccion de la otra página´
        }, 2000);
    }
}

function distribucion() {
    location.href = './distribución.html';
}

function enviarConfirmacion() {
    location.href = './confirmacionUsuario.html';
}
//cerrarSesion()
function enviarModificarPregunta() {
    location.href = './modificarPregunta.html';
}

function cerrarSesion() {
    location.href = '../CerrarSesion';
}

function consultarPregunta() {
    location.href = './respuestasPregunta.html';
}

function cancelar() {
    window.history.back();
}