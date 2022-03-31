<%@page import="Control.GestionarPregunta"%>
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
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <% 
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <title>Preguntas Usuario</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/preguntasPendientes.css">
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <link rel="icon" type="image/png" href="./img/icono.png">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img//Logo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article><b>QUETZUAL</b></article>
            <div class="menu">
                <a href="./inicioDoctor.jsp">
                    <img src="./img/bx-home.png" alt="Simbolo de usuario " class="svg ">
                </a>
                <a href="./cuentaDoctor.jsp">
                    <img src="./img/bx-user-circle.png" width="40" alt="Signo de pregunta" class="svg">
                </a>
                <a href="./ranking.jsp">
                    <img src="./img/bx-line-chart.png" alt="Signo de editar" class="svg">
                </a>
                <a href="../CerrarSesion">
                    <img src="./img/salir.png" alt="Signo de pregunta" class="svg">
                </a>
                &nbsp;
                &nbsp;
                &nbsp;
                &nbsp;

            </div>
        </nav>
    </header>


    <div class="title">
        <h1>Preguntas Usuario</h1>
        <hr>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript: filtrar(this.value);">
            <option value="1">Preguntas pendientes</option>
            <option value="2">Preguntas respondidas</option>
        </select>
    </div>
    <div id="cambiar">
        
        </div>
    <script src="./JS/redirigir.js"></script>
    <script>
        function responder(id){
            location.href='./responderPregunta.jsp?id='+id 
        }
        function rechazar(id){
            location.href='./rechazarPregunta.jsp?id='+id 
        }
        function filtrar(filtro){
            $.post('../Filtropre', {
                    filtro: filtro
            }, function(responseText) {
                    $('#cambiar').html(responseText);
            });
        }
        filtrar(1)
        
        
        var socket1 = new WebSocket("wss://quetzual.herokuapp.com/Pregunta");
        socket1.onmessage = function (event) {
            var filtros = parseInt(document.getElementById("filtro").value);
            if(filtros === 1){
                setTimeout(function() {
                        filtrar(1);
                    }, 1000);
            }
        }
    </script>
</body>

</html>
