

<%@page import="Modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java"%>

<% 
    HttpSession sesion = request.getSession(true);
    if(sesion.getAttribute("usuario") != null){
        MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
        if(usu.getId_rol() != 2){
            response.sendRedirect("../index.jsp");
        }
    }else{
        response.sendRedirect("../index.jsp");
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
    <link rel="stylesheet" href="./CSS/cuentaDoctor.css">
    <link rel="stylesheet" href="./CSS/star-rating-svg.css">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img/logotipo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article>Mi cuenta</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./inicioDoctor.jsp">
                <img src="./img/bx-home.svg" alt="Imagen inicio"> Inicio
            </a>
            <a href="./preguntasPendientes.jsp">
                <img src="./img/bx-edit.svg" alt="Imagen "> Gestionar preguntas
            </a>
            <a href="./ranking.jsp">
                <img src="./img/bx-line-chart.svg" alt="Signo de editar" class="svg"> Ranking
            </a>
        </div>
    </header>

    <div class="title">
        <h1>Preguntas Respondidas</h1>
        <hr>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro">
            <option selected disabled hidden>Selecciona el filtro de preguntas</option>
            <option value="a">Preguntas Rechazadas</option>
            <option value="a">Preguntas Respondidas</option>
        </select>
    </div>
    <div class="main_container">
        <div class="mini_header">
            <h2>Edad</h2>
            <h2>Categoria</h2>
        </div>
        <div class="pregunta">
            <img src="./img/bxs-user.svg" class="img">
            <div class="preguntas">
                <h3>Tuve relaciones con mi pareja, y deacuerdo a mis sintomas creo que tengo S.I.D.A. pero temo ir al medico. Podría por favor ayudarme a saber si podría padecer S.I.D.A. y cual sería un posible tratamiento por favor? Estos son mis sintomas:
                    1.- Dolor al tragar 2.- Diarrea 3.- Llagas en la ingle</h3>
            </div>
        </div>
        <div class="respuesta">
            <div class="respuestas">
                <h3>Tus síntomas en general indican que podrías padecer S.I.D.A. Sin embargo, ningún médico puede darte un diagnóstico sin realizar estudio de laboratorio. El tratamiento consiste en antivirales para el VIH. Es necesario que acudas a un médico
                    lo más pronto posible. No debes temer de ir al doctor, es mejor ir a tiempo y no cuando sea demasiado tarde. Puedes pedir a una persona de confiansa que te acompañe para sentirte más tr</h3>
            </div>
            <img src="./img/bx-plus-medical.svg" class="img">
        </div>
    </div>
    </div>
    <div class="card">
        <div class="mini_header2">
            <h2>22/09/2021</h2>
        </div>
        <div class="pregunta2">
            <img src="./img/bxs-user.svg" alt="">
            <div class="preguntas2">
                <h3>Lorem ipsum dolor sit amet consectetur adipisicing elit. Culpa atque quo minus dolorum id cupiditate odit eligendi in qui voluptates?</h3>
            </div>
            <h1 class="h1">Razón del rechazo</h1>
            <div class="preguntas2">
                <h3>Lorem ipsum dolor sit amet consectetur adipisicing elit. Adipisci porro iure perferendis, nemo in, aliquid laudantium sequi iste blanditiis suscipit fugit velit, non minima ducimus? Nisi asperiores repellat itaque laboriosam.</h3>
            </div>
        </div>
    </div>
    <script src="./JS/redirigir.js"></script>
</body>

</html>
