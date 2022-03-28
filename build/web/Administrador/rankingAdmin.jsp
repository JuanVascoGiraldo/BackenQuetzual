<%@page import="java.util.Calendar"%>
<%@page import="Control.GestionarUsuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java"%>

<% 
    HttpSession sesion = request.getSession(true);
    if(sesion.getAttribute("usuario") != null){
        MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
        if(usu.getId_rol() != 3){
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
    <link rel="stylesheet" href="./CSS/rankingAdmin.css">
    <link rel="icon" type="image/png" href="./img/icono.png">
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
</head>

<body>
    <button class="menu" data-open="modalR"><img src="./img/bx-menu (2).svg"></button>
    <h1>Mejores desempeños</h1>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:filtrar(this.value);">
            <option selected disabled hidden>Filtrar por fecha</option>
            <option value="1" >General</option>
            <option value="2" >Mensual</option>
        </select>
    </div>
    <div class="main_container">
        <div class="grid">
            <div id="cambiar">
                
            </div>
            
        </div>
    </div>
    <div class="modal" id="modalR">
        <aside class="modal-dialog">
            <img src="./img/LogoBlancoLetrasSinFondo.png">
            <button onclick="enviarSesionAdmin()">Inicio</button>
            <button onclick="enviarCuentaAdmin()">Cuenta</button>
            <button onclick="enviarAdminDoctores()">Administrar Doctores</button>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </aside>
    </div>
    <script src="./JS/redirigir.js"></script>
    <script src="./JS/funcionModal2.js"></script>
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