let expresioncorreo = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;
let expresiontextnumber = /^[a-zA-Z0-9àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.]+$/;
let expresioncontra = /^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$/;
let expresionfecha = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$/;
let expresiononlytext = /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð]+$/u;

function validarcorreo(correo) {
    var validar = expresioncorreo.test(correo);
    if (!validar) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Ingrese un correo valido'
        });
    }
    return validar;
}

function validarcontrasena(contrasena) {
    var validar = expresioncontra.test(contrasena);
    if (!validar) {
        Swal.fire({
            icon: 'error',
            title: 'Ingrese una contraseña valida',
            text: 'La contraseña debe tener al entre 8 y 16 caracteres, al menos un dígito, al menos una minúscula y al menos una mayúscula.'
        });
    }
    return validar;
}

function validarnombre(nombre) {
    var validar = expresiononlytext.test(nombre);
    if (!validar) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Ingrese un nombre valido (solo letras)'
        });
        return false;
    } else if (nombre.length > 20 || nombre.length == 0) {
        Swal.fire({
            icon: 'error',
            title: 'El tamaño del nombre no es correcto',
            text: 'El nombre tiene que medir entre 1 y 20 caracteres'
        });
        return false;
    } else {
        return true;
    }
}

function validarfecha(fecha) {
    var validar = expresionfecha.test(fecha);
    if (!validar) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Ingrese una fecha valida'
        });
    }
    return validar;
}

function validarPregunta(pregunta) {
    var validar = expresiontextnumber.test(pregunta);
    if (pregunta.length > 200 || pregunta.length < 11) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Solo puedes ingresar como maximo 100 caracteres y minimo 10 caracteres'
        });
        return false;
    } else if (!validar) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Solo puedes ingresar letras y numeros en el campo'
        });
        return false;
    } else {
        return true;
    }
}

function registrarr() {
    var fecha = document.getElementById('fecha').value;
    var email = document.getElementById('correo').value;
    var nombre = document.getElementById('nombre').value;
    var pass = document.getElementById('password').value;
    var confpas = document.getElementById('confpass').value;
    if (pass != confpas) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Las contraseñas no coinciden'
        });
    } else if (validarfecha(fecha) && validarnombre(nombre) && validarcorreo(email) && validarcontrasena(pass)) {
        Swal.fire({
            icon: 'success',
            title: 'Felicidades',
            text: 'Has registrado una cuenta'
        });
        document.registrar.submit();
    }
}

function iniciars() {
    var email = document.iniciar.email.value;
    var pass = document.iniciar.pass.value;
    if (validarcorreo(email) && validarcontrasena(pass)) {
        Swal.fire({
            icon: 'success',
            title: 'Bien hecho',
            text: 'Se ha iniciado Sesión'
        });
        document.iniciar.submit();
    }
}

function modificarcuenta() {
    var fecha = document.getElementById('fecha').value;
    var email = document.getElementById('correo').value;
    var nombre = document.getElementById('nombre').value;
    if (validarfecha(fecha) && validarnombre(nombre) && validarcorreo(email)) {
        Swal.fire({
            icon: 'success',
            title: 'Perfecto',
            text: 'has modificado tu cuenta'
        });
        //document.modcuenta.submit;
        setTimeout(function() {
            document.modicuenta.submit();
        }, 2000);
    }
}

function modificarContra() {
    var antpass = document.getElementById('antpass').value;
    var pass = document.getElementById('password').value;
    var confpas = document.getElementById('confpass').value;
    if (pass != confpas) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'No coinciden las nuevas contraseñas'
        });
    } else if (validarcontrasena(pass) && validarcontrasena(antpass)) {
        Swal.fire({
            icon: 'success',
            title: 'Perfecto',
            text: 'Se ha modificado la contraseña correctamente'
        });
        //document.modcontra.submit;
        setTimeout(function() {
            document.ModContra.submit();
        }, 2000);
    }
}

function HPregunta() {
    var pregunta = document.getElementById("pregunta").value;
    if (validarPregunta(pregunta)) {
        document.HacerP.submit();
    }
}

function MPregunta() {
    var pregunta = document.getElementById("Mpregunta").value;
    if (validarPregunta(pregunta)) {
       document.ModificarPre.submit();
    }
}

function RechaPregunta() {
    var razon = document.rechapre.razon.value;
    if (validarPregunta(razon)) {
        Swal.fire({
            icon: 'success',
            title: 'Correcto',
            text: 'Se ha rechazado la pregunta con exito'
        });
        document.rechapre.submit;
    }
}

function ResPregunta() {
    var pregunta = document.repre.pre.value;
    var respuesta = document.repre.res.value;
    if (validarPregunta(pregunta) && validarPregunta(respuesta)) {
        Swal.fire({
            icon: 'success',
            title: 'Correcto',
            text: 'Se ha respondido la pregunta con exito'
        });
        document.repre.submit;
    }
}