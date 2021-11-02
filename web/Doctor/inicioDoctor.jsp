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
    <link rel="stylesheet" href="./CSS/inicioDoctor.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="../img/logotipo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article>Estadisticas</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./paginaError1.html">
                <img src="./img/bxs-bar-chart-alt-2.svg" alt="Imagen "> Inducción
            </a>
            <a href="./cuentaDoctor.jsp">
                <img src="./img/bx-user-circle.svg" width="40" alt="Signo de pregunta" class="svg"> Mi cuenta
            </a>
            <a href="./preguntasPendientes.jsp">
                <img src="./img/bx-edit.svg" alt="Imagen "> Gestionar preguntas
            </a>
            <a href="./ranking.jsp">
                <img src="./img/bx-line-chart.svg" alt="Signo de editar" class="svg"> Ranking
            </a>
        </div>
    </header>
    <div>
        <h1>Bienvenido Doctor</h1>
        <p>Estos son los datos más recientes desde la ultima vez</p>
    </div>
    <div class="bar">
        <canvas id="docChart"></canvas>
    </div>
    <script src="./JS/redirigir.js"></script>
    <script type="text/javascript" src="./JS/graficas.js"></script>
</body>

</html>
