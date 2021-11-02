var cont = 0;

function callm() {
    const preguntaIn = document.getElementById('pregunta').value;
    const respuestaOut = "cubito Verde miau miau comparacion pez ultra dinamita";
    //Juan ahí agregas la llamada a la pregunta 2, le puse respuesta porque equisde
    const espacio = " ";
    const arrayDeCadenas = preguntaIn.split(espacio);
    const arrayDeRespuestas = respuestaOut.split(espacio);
    for (var i = 0; i < arrayDeCadenas.length; i++) {
        for (var j = 0; j < arrayDeRespuestas.length; j++) {
            if (arrayDeCadenas[i] == arrayDeRespuestas[j]) {
                cont++;
                break;
            }
        }
    }
    var porcentaje = cont / arrayDeCadenas.length;
    porcentaje *= 100;
    cont = 0;
    var m = false;
    if (porcentaje > 49) {
        m = true;
    }
    return m;
    //HPregunta();
}