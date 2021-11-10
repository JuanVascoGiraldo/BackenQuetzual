let expresioncorreo = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;
let expresiontextnumber = /^[a-zA-Z0-9àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.]+$/;
let expresioncontra = /^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$/;
let expresionfecha = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$/;
let expresiononlytext = /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð]+$/u;

function validarcorreo(correo) {
    var correo = document.getElementById("correo").value;
    var validar = expresioncorreo.test(correo);
    if (!validar) {
        alert("Ingrese un correo válido");
    }
    return validar
}

function validarcontrasena(contrasena) {
    var contrasena = document.getElementById("contrasena").value;
    var validar = expresioncontra.test(contrasena);
    if (!validar) {
        alert("Ingrese una contraseña válida, la contraseña debe tener al menos entre 8 y 16 caracteres, al menos un dígito, una minúscula y una mayúscula.");
    }
    return validar;
}

function validarnombre(nombre) {
    var nombre = document.getElementById("nom_usu").value;
    var validar = expresiononlytext.test(nombre);
    if (!validar) {
        alert("Ingrese un nombre válido valida (solo letras)");
        return false;
    } else if (nombre.length > 20 || nombre.length == 0) {
        alert("El tamaño del nombre no es correcto")
        return false;
    } else {
        return true;
    }
}

function validarfecha(fecha) {
    var validar = expresionfecha.test(fecha);
    if (!validar) {
        alert("ingresen una fecha valida")
    }
    return validar;
}

function validarPregunta(pregunta) {
    var validar = expresiontextnumber.test(pregunta);
    if (!validar) {
        alert("solo puedes ingresar letras y numeros en el campo");
        return false;
    } else if (pregunta.length > 100 || pregunta.length == 0) {
        alert("solo puedes ingresar como maximos 100 caracteres");
        return false;
    } else {
        return true;
    }
}

function registrarr() {
    var fecha = document.registrar.fecha.value;
    var email = document.registrar.email.value;
    var nombre = document.registrar.nombre.value;
    var pass = document.registrar.pass.value;
    var confpas = document.registrar.confpass.value;
    if (pass != confpas) {
        alert("Las contraseñas no coinciden");
    } else if (validarfecha(fecha) && validarnombre(nombre) && validarcorreo(email) && validarcontrasena(pass)) {
        alert("has registrado una cuenta")
        document.registrar.submit;
    }
}

function iniciars() {
    var email = document.iniciar.email.value;
    var pass = document.iniciar.pass.value;
    if (validarcorreo(email) && validarcontrasena(pass)) {
        alert("Se ha iniciado Sesión")
        document.iniciar.submit;
    }
}

function modificarcuenta() {
    var fecha = document.modcuenta.fecha.value;
    var email = document.modcuenta.email.value;
    var nombre = document.modcuenta.nombre.value;
    if (validarfecha(fecha) && validarnombre(nombre) && validarcorreo(email)) {
        alert("has modificado tu cuenta")
        document.modcuenta.submit;
    }
}

function modificarContra() {
    var antpass = document.modcontra.antpass.value;
    var pass = document.modcontra.pass.value;
    var confpas = document.modcontra.confpass.value;
    if (pass != confpas) {
        alert("No coinciden las nuevas contraseñas");
    } else if (validarcontrasena(pass) && validarcontrasena(antpass)) {
        alert("Se ha modificado la contraseña correctamente");
        document.modcontra.submit;
    }
}

function HPregunta() {
    var pregunta = document.getElementById("pregunta").value;
    if (validarPregunta(pregunta)) {
        alert("se ha realizado la pregunta con exito");
    }
}

function MPregunta() {
    var pregunta = document.getElementById("Mpregunta").value;
    if (validarPregunta(pregunta)) {
        alert("se ha realizado la pregunta con exito");
    }
}

function RechaPregunta() {
    var razon = document.getElementById("razon").value;
    var allvalid = true;
    if (razon.length <11) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡Todos los campos son obligatorios, no puedes rechazar la pregunta sin tener la pregunta ni escribir la razón del rechazo!',
            icon: 'error'
        });
        allvalid = false;
        return false;
    }
    if ( razon.length > 200) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡Sólo puedes ingresar como máximo 100 caracteres por pregunta y razón de rechazo!',
            icon: 'error'
        });
        allvalid = false;
        return false;
    }
    if (!expresiontextnumber.test(razon)) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡Sólo puedes ingresar letras y números en la pregunta y en la razón de rechazo!',
            icon: 'error'
        });
        allvalid = false;
        return false;
    }
    if (!allvalid) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡No se realizó correctamente el rechazar la pregunta!',
            icon: 'error'
        });
        return false;
    } else {
        document.getElementById('modalR').classList.add(isVisible);
    }
}

function ResPregunta() {
    var pregunta = document.getElementById("pregunta").value;
    var respuesta = document.getElementById("respuesta").value;
    var allvalid = true;
    if (pregunta.length < 11 || respuesta.length < 11) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡Todos los campos son obligatorios, no puedes responder la pregunta sin tener la pregunta ni escribir la respuesta!',
            icon: 'error'
        });
        allvalid = false;
        return false;
    }
    if (pregunta.length > 200 || respuesta.length > 200) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡Sólo puedes ingresar como máximo 100 caracteres por pregunta y respuesta!',
            icon: 'error'
        });
        allvalid = false;
        return false;
    }
    if (!expresiontextnumber.test(pregunta) || !expresiontextnumber.test(respuesta)) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡Sólo puedes ingresar letras y números en la pregunta y en la respuesta!',
            icon: 'error'
        });
        allvalid = false;
        return false;
    }
    if (!allvalid) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡No se realizó correctamente el responder la pregunta!',
            icon: 'error'
        });
        return false;
    } else {
        document.getElementById('modalR').classList.add(isVisible);
        setTimeout(function() {
            document.Rpregunta.submit();
        }, 1000);
        
    }
}

function agregarRespuestares() {
    var respuesta = document.getElementById("respuestas").value;
    var allvalid = true;
    if (respuesta.length < 11) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡Todos los campos son obligatorios, no puedes responder la pregunta sin tener la pregunta ni escribir la respuesta!',
            icon: 'error'
        });
        allvalid = false;
        return false;
    }
    if (respuesta.length > 200) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡Sólo puedes ingresar como máximo 100 caracteres por pregunta y respuesta!',
            icon: 'error'
        });
        allvalid = false;
        return false;
    }
    if (!expresiontextnumber.test(respuesta)) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡Sólo puedes ingresar letras y números en la pregunta y en la respuesta!',
            icon: 'error'
        });
        allvalid = false;
        return false;
    }
    if (!allvalid) {
        Swal.fire({
            title: '¡Oops!',
            text: '¡No se realizó correctamente el responder la pregunta!',
            icon: 'error'
        });
        return false;
    } else {
        document.getElementById('modalR').classList.add(isVisible);
        setTimeout(function() {
          document.responder.submit();  
        }, 1000);
        
    }
}