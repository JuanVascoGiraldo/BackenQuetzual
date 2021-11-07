
<%@page import="java.util.List"%>
<%@page import="Control.GestionarPregunta"%>
<%@page import="Control.GestionarPregunta"%>
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
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    List<MPregunta> pre = GestionarPregunta.ConsultarAllPreRes(usu.getClave() );
    
    
    int fil = 0;
    try{
        fil = Integer.valueOf(request.getParameter("fil"));
        if(fil > 5){
            fil = 0;
        }
    }catch(Exception e){
        fil = 0;
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
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option selected disabled hidden>Selecciona el tema de tu interes</option>
            <option value="sesionUsuario.jsp?fil=1">Enfermedades de transmisión sexual</option>
            <option value="sesionUsuario.jsp?fil=5">Anticonceptivos</option>
            <option value="sesionUsuario.jsp?fil=2">Embarazo</option>
            <option value="sesionUsuario.jsp?fil=3">Salud sexual femenina</option>
            <option value="sesionUsuario.jsp?fil=4">Salud sexual masculina</option>
        </select>
    </div>
    <% 
        for(MPregunta res: pre){
            if(fil == 0 || fil == res.getId_catgen() ){
    %>
    <div class="main_container">
        <div class="mini_header">
            <h2><%=res.getEdad_usu() %> años</h2>
            <h2><% 
                 if(res.getId_catgen() == 1){
                 %>Enfermedades de transmisión sexual<%
                 }else if(res.getId_catgen() == 2){
                 %>Embarazo<%
                 }else if(res.getId_catgen() == 3){
                 %>Salud sexual femenina<%
                 }else if(res.getId_catgen() == 4){
                 %> Salud sexual masculina<%
                 }else if(res.getId_catgen() == 5){
                 %>Anticonceptivos <%
                 }
               
                %></h2>
            <h2><%=res.getCantidadRes() %> Respuestas</h2>
        </div>
        <div class="pregunta">
            <img src="./img/bxs-user.svg">
            <div class="preguntas">
                <h3><%=res.getDes_pre() %></h3>
            </div>
        </div>
        <div class="respuesta">
            <a href="./respuestasPregunta.jsp?id=<%=res.getId_pre() %>&&re=0">Ver respuestas</a>
        </div>
    </div>
    <% 
        }}
    %>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>

</html>