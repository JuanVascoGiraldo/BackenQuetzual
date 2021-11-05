<%@page import="java.util.List"%>
<%@page import="Control.GestionarPregunta"%>
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
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    List<MPregunta> lista = GestionarPregunta.ConsultarallPrePen(usu.getClave());
%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Preguntas pendientes</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/preguntasPendientes.css">
</head>

<body>
    <header class=" header ">
        <nav class="navegacion ">
            <img src="./img/logotipo.png " alt="Logotipo oficial de Quetzual " class="logo ">
            <article>Gestionar preguntas</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./inicioDoctor.jsp">
                <img src="./img/bx-home.svg" alt="Simbolo de usuario " class="svg "> Inicio
            </a>
            <a href="./cuentaDoctor.jsp">
                <img src="./img/bx-user-circle.svg" width="40" alt="Signo de pregunta" class="svg"> Mi cuenta
            </a>
            <a href="./ranking.jsp">
                <img src="./img/bx-line-chart.svg" alt="Signo de editar" class="svg"> Ranking
            </a>
        </div>
    </header>
    <div class="title">
        <h1>Preguntas pendientes</h1>
        <hr>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option value="./preguntasPendientes.jsp">Preguntas pendientes</option>
            <option value="./preguntasDoctor.jsp">Preguntas respondidas</option>
        </select>
    </div>
    <% 
        for(MPregunta pre: lista){
    %>
    <div class="main_container">
        <div class="mini_header2">
            <h2><%=pre.getFecha_pre() %></h2>
        </div>
        <div class="pregunta">
            <img src="./img/bxs-user.svg" alt="">
            <textarea name="" id="" class="area" placeholder="Escribe aquí tu pregunta" disabled><%=pre.getDes_pre() %></textarea>
        </div>
        <div class="flex">
            <button class="question" onclick="responder(<%=pre.getId_pre() %>)">Responder pregunta</button>
            <button class="cs" onclick="rechazar(<%=pre.getId_pre() %>)">Rechazar pregunta</button>
        </div>
    </div>
    <% 
        }
    %>
    <script src="./JS/redirigir.js"></script>
    <script>
        function responder(id){
            location.href='./responderPregunta.jsp?id='+id 
        }
        function rechazar(id){
            location.href='./rechazarPregunta.jsp?id='+id 
        }
    </script>
</body>

</html>
