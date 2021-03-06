let expresioncorreo = /^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$/;
let expresiontextnumber = /^[a-zA-Z0-9àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,\. \? \¿]+$/;
let expresioncontra = /^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$/;
let expresionfecha = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$/;
let expresiononlytext = /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð]+$/u;
var socket1 = new WebSocket("wss://quetzual.herokuapp.com/Pregunta");
var loading = "<script>"+
           "Swal.fire({"+
            "title: 'Datos enviados',"+
            "html: 'Los datos fueron enviados espere un momento',"+
           "timer: 10000,"+
            "timerProgressBar: true,"+
            "didOpen: () => {"+
              "Swal.showLoading()"+
            "}"+
          "})"+
    "</script>";


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

function validarsexo(sexo){
    var sexo1 = parseInt(sexo);
    if(sexo1<1 || sexo1 >3){
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Sexo Invalido'
        });
        return false;
    }else{
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
    }else{
        var fechas = fecha.split('-');
        const hoy = new Date();
        var ano = hoy.getFullYear();
        console.log(fechas[0])
        var diferencia = ano-parseInt(fechas[0]);
        console.log(diferencia)
        if(diferencia < 11 || diferencia > 100){
            validar = false;
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Tienes que tener al menos 11 años para utilizar la aplicacion'
            });
        }
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
    var sexo = document.getElementById("sexo").value;
    if (pass != confpas) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Las contraseñas no coinciden'
        });
    } else if (validarsexo(sexo) && validarfecha(fecha) && validarnombre(nombre) && validarcorreo(email) && validarcontrasena(pass)) {
        $('#cambiar1').html(loading);
        
        $.post('RegistrarUsuario', {
                nombre: nombre,
                correo: email,
                contra: pass,
                fecha: fecha,
                sexo: sexo 
        }, function(responseText) {
                $('#cambiar1').html(responseText);
        });
    }
}

function iniciars() {
    var email = document.iniciar.email.value;
    var pass = document.iniciar.pass.value;
    if (validarcorreo(email) && validarcontrasena(pass)) {
        document.iniciar.submit();
    }
}

function modificarcuenta() {
    var fecha = document.getElementById('fecha').value;
    var nombre = document.getElementById('nombre').value;
    if (validarfecha(fecha) && validarnombre(nombre)) {
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
        socket1.send("Modificada");
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
        //document.rechapre.submit;
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
        //document.repre.submit;
    }
}

function ReContra(){
    var correo = document.recuperar.email.value;
    if(validarcorreo(correo)){
        $('#cambiar2').html(loading);
        $.post('RecuperarContra', {
                email: correo
        }, function(responseText) {
                $('#cambiar2').html(responseText);
        });
    }
}

function ModCorreo(){
    var correo = document.modemail.correo.value;
    if(validarcorreo(correo)){
        $('#cambiar').html(loading);
        $.post('ModiCorreo', {
                correo: correo
        }, function(responseText) {
                $('#cambiar').html(responseText);
        });
    }

}

function RecuperarContra(){
    var pass = document.getElementById('contra').value;
    var confpas = document.getElementById('confcontra').value;
    if (pass != confpas) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'No coinciden las nuevas contraseñas'
        });
    } else if (validarcontrasena(pass) && validarcontrasena(confpas)) {
        setTimeout(function() {
            document.reccontra.submit();
        }, 2000);
    }
}