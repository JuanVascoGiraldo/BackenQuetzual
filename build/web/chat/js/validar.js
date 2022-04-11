let expresioncorreo = /^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$/;
let expresiontextnumber = /^[a-zA-Z0-9àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,\. \? \¿]+$/;
let expresiononlytext = /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ]+$/u;
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

function validarDuda(Duda) {
    var validar = expresiontextnumber.test(Duda);
    if (Duda.length > 150 || Duda.length < 11) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Solo puedes ingresar como maximo 150 caracteres y minimo 10 caracteres en tu duda'
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

function validartema(tema) {
    var validar = expresiononlytext.test(tema);
    if (!validar) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Ingresa un tema valido'
        });
        return false;
    } else if (tema.length > 20 || tema.length < 6) {
        Swal.fire({
            icon: 'error',
            title: 'El tamaño del tema no es correcto',
            text: 'El tema debe medir entre 5 a 20 caracteres'
        });
        return false;
    } else {
        return true;
    }
}

function sendcorreo(){
    var correo = document.getElementById('correo').value;
    var tema = document.getElementById('tema').value;
    var duda = document.getElementById('duda').value;
    if(validartema(tema) && validarDuda(duda) && validarcorreo(correo)){
        $('#cambiar1').html(loading);
        
        $.post('../CorreoSoporte', {
                correo: correo,
                tema: tema,
                duda: duda
        }, function(responseText) {
                $('#cambiar1').html(responseText);
        });
    }
}

