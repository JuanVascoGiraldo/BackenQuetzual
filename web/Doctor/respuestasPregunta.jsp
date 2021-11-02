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
    <title>Respuestas</title>
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
            <article>Respuestas</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./preguntasDoctor.jsp">
                <img src="./img/bxs-left-arrow.svg" alt="Imagen"> Volver
            </a>
        </div>
    </header>
    <form class="alineacion">
        <input type="text" placeholder="Respuesta" class="area">
        <button onclick="agregarRespuesta()" class="submit">Agregar respuesta</button>
    </form>
    <div class="main_container">
        <div class="mini_header">
            <h2>Dr. Montero</h2>
        </div>
        <div class="respuesta">
            <div class="respuestas">
                <h3>Tus síntomas en general indican que podrías padecer S.I.D.A. Sin embargo, ningún médico puede darte un diagnóstico sin realizar estudio de laboratorio. El tratamiento consiste en antivirales para el VIH. Es necesario que acudas a un médico
                    lo más pronto posible. No debes temer de ir al doctor, es mejor ir a tiempo y no cuando sea demasiado tarde. Puedes pedir a una persona de confiansa que te acompañe para sentirte más tr</h3>
            </div>
            <img src="./img/bx-plus-medical.svg" alt="">
        </div>
    </div>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>

</html>
