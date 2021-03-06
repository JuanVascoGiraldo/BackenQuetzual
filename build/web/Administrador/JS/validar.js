let expresioncorreo = /^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$/;
let expresiontextnumber = /^[a-zA-Z0-9àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ?¿,.]+$/;
let expresioncontra = /^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$/;
let expresionfecha = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$/;
let expresiononlytext = /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð]+$/u;
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

function validarnombre(nombre) {
    var validar = expresiononlytext.test(nombre);
    if (!validar) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Ingrese un nombre valido (solo letras)'
        });
        return false;
    } else if (nombre.length > 30 || nombre.length == 0) {
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
        $.post('../RegistrarUsuario', {
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

function registrardr() {
    var fecha = document.getElementById("date").value;
    var email = document.getElementById("email").value;
    var nombre = document.getElementById("name").value;
    var pass = document.getElementById("password1").value;
    var confpass = document.getElementById("passwordConfirm1").value;
    if (validarnombre(nombre) && validarfecha(fecha) && validarcorreo(email) && validarcontrasena(pass) && (pass = confpass)) {
        
        setTimeout(function() {
           document.registrarDoc.submit();
        }, 1000);
    } else if (pass != confpass) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Las contraseñas no coinciden'
        });
    }
    //document.registrar.submit;

}

function modificarcuentadr() {
    var fecha = document.getElementById("fechad").value;
    var email = document.getElementById("correod").value;
    var nombre = document.getElementById("nombred").value;
    var pass = document.getElementById("password").value;
    if (validarnombre(nombre) && validarfecha(fecha) && validarcorreo(email) && validarcontrasena(pass)) {
        document.getElementById("modalR").classList.add(isVisible);
        document.ModCuentaDoctor.submit();
    }
}

function modificarcuentaAdmin() {
    var fecha = document.getElementById("fechaAdmin").value;
    var nombre = document.getElementById("nombreadmin").value;
    if (validarnombre(nombre) && validarfecha(fecha)) {
        document.getElementById("modalR").classList.add(isVisible);
        setTimeout(function() {
            document.ModCuentaAdmin.submit();
        }, 2000);
        
    }
    //

}

function modificarContra() {
    var antpass = document.getElementById("passwordact").value;
    var pass = document.getElementById("newpassword").value;
    var confpass = document.getElementById("newpasswordconfirm").value;
    if (validarcontrasena(pass) && validarcontrasena(antpass) && (pass = confpass)) {
        
        //
        setTimeout(function() {
            document.ModiContraAdmin.submit();
        }, 2000);
    } else if (pass != confpass) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'No coinciden las nuevas contraseñas'
        });
    }
}

function ReContra(){
    var correo = document.recuperar.email.value;
    if(validarcorreo(correo)){
        $('#cambiar2').html(loading);
        $.post('../RecuperarContra', {
                email: correo
        }, function(responseText) {
                $('#cambiar2').html(responseText);
        });
    }
}

function iniciars() {
    var email = document.iniciar.email.value;
    var pass = document.iniciar.contra.value;
    if (validarcorreo(email) && validarcontrasena(pass)) {
        document.iniciar.submit();
    }
}