
<%@page import="Modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java"%>

<% 
    HttpSession sesion = request.getSession(true);
    if(sesion.getAttribute("usuario") != null){
        MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
        if(usu.getId_rol() != 1){
            response.sendRedirect("index.jsp");
        }
    }else{
        response.sendRedirect("index.jsp");
    }

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/sesionUsuario.css">
    <link rel="stylesheet" href="./CSS/star-rating-svg.css">
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="./JS/jquery.star-rating-svg.js"></script>
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img/logotipo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article>Inicio</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./paginaError2.html">
                <img src="./img/bxs-bar-chart-alt-2.svg" alt="Imagen "> Inducción
            </a>
            <a href="./cuenta.jsp">
                <img src="./img/bx-user-circle.svg" width="40" alt="Signo de pregunta" class="svg"> Mi cuenta
            </a>
            <a href="./preguntasRespondidas.jsp">
                <img src="./img/bx-question-mark.svg" alt="Imagen "> Mis preguntas
            </a>
            <a href="./hacerPregunta.jsp">
                <img src="./img/bx-edit-alt.svg" alt="Signo de editar" class="svg"> Quiero preguntar
            </a>
        </div>
    </header>

    <div class="title">
        <h1>Bienvenido usuario</h1>
        <hr>
        <p>En este espacio puedes consultar las preguntas que otros usuarios ya han realizado previamente.
        </p>
        <p>¡Tal vez tu duda ya ha sido contestada!</p>
        <p>Puedes explorar este espacio usando el combobox para buscar preguntas que se relacionan directamente con tu duda.</p>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro">
            <option selected disabled hidden>Selecciona el tema de tu interes</option>
            <option value="a">Enfermedades de transmisión sexual</option>
            <option value="a">Anticonceptivos</option>
            <option value="a">Embarazo</option>
            <option value="a">Salud sexual femenina</option>
            <option value="a">Salud sexual masculina</option>
        </select>
    </div>
    <div class="main_container">
        <div class="mini_header">
            <h2>Edad</h2>
            <h2>Categoria</h2>
            <h2>3 respuestas</h2>
        </div>
        <div class="pregunta">
            <img src="./img/bxs-user.svg">
            <div class="preguntas">
                <h3>Tuve relaciones con mi pareja, y deacuerdo a mis sintomas creo que tengo S.I.D.A. pero temo ir al medico. Podría por favor ayudarme a saber si podría padecer S.I.D.A. y cual sería un posible tratamiento por favor? Estos son mis sintomas:
                    1.- Dolor al tragar 2.- Diarrea 3.- Llagas en la ingle</h3>
            </div>
        </div>
        
        <div class="respuesta">
            <a href="./respuestasPregunta.jsp">Ver respuestas</a>
        </div>
    </div>
    <div class="modal" id="modalR">
        <div class="card">
            <article>
                <b>Tu Calificación ha sido registrada</b>
            </article>
            <img src="./img/check-square-solid-240.png" alt="">
        </div>
    </div>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>

</html>