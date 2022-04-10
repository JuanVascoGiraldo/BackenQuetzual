<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="Control.GestionarUsuario"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
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
        %> 
        <jsp:forward page="index.jsp">
        <jsp:param name="Error" value="Es obligatorio identificarse" />
         </jsp:forward>
<%
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <% 
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <title>Ranking</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/ranking.css">
    <link rel="icon" type="image/png" href="./img/icono.png">
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img//Logo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article><b>QUETZUAL</b></article>
            <div class="menu">
                <a href="./inicioDoctor.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Inicio</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="./cuentaDoctor.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Cuenta</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="./preguntasPendientes.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Preguntas</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="../CerrarSesion" style="margin-right: 2%; margin-left: 2%;">
                    <img src="./img/salir.png" alt="Signo de pregunta" class="svg">
                </a>
                &nbsp;
                &nbsp;

            </div>
        </nav>
    </header>


    <div class="title">
        <h1>Mejores desempeños</h1>
        <hr>
        <p>En este espacio puedes consultar el ranking de los doctores que al igual que tu han colaborado a orientar al usuario y que han destacado en base a los puntos obtenidos.</p>
        <p>Puedes consultarlo de forma general o mensual.</p>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:filtrar(this.value);">
            <option selected disabled hidden>Filtrar por fecha</option>
            <option value="1"  >General</option>
            <option value="2"  >Mensual</option>
        </select>
    </div>
    <div class="main_container">
        <div class="grid">
            <div id="cambiar">
            
            </div>
        </div>
    </div>
    <script src="./JS/redirigir.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function filtrar(filtro){
            $.post('../FiltroRanking', {
                    filtro: filtro
            }, function(responseText) {
                    $('#cambiar').html(responseText);
            });
        }
        filtrar(1)
    </script>
</body>

</html>

