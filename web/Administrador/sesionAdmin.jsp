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
        response.sendRedirect("../index.jsp");
    }

%>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/sesionAdmin.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>

<body>
    <aside>
        <img src="./img/logotipo.png">
        <button onclick="enviarAdminDoctores()">Administrar doctores</button>
        <button onclick="enviarCuentaAdmin()">Cuenta</button>
        <button onclick="enviarRankingAdmin()">Ranking</button>
        <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
    </aside>
    <h1>Bienvenido Administrador</h1>
    <div>Estos son los datos más recientes desde la última vez</div>
    <div class="bar">
        <canvas id="admChart"></canvas>
    </div>
    <script src="./JS/redirigir.js"></script>
    <script type="text/javascript" src="./JS/graficas.js"></script>
</body>

</html>
