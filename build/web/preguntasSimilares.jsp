
<%@page import="Control.Cifrado"%>
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
        %> 
        <jsp:forward page="index.jsp">
        <jsp:param name="Error" value="Es obligatorio identificarse" />
         </jsp:forward>
<%
    }
    request.setCharacterEncoding("UTF-8");
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    String pre = (String)sesion.getAttribute("pre");
    if(pre == null){
         response.sendRedirect("hacerPregunta.jsp");
    }
    List<MPregunta> simi = GestionarPregunta.PreguntasSimilares(pre, usu.getClave());
    
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
    <title>Preguntas Similares</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/sesionUsuario.css">
    <link rel="stylesheet" href="./CSS/star-rating-svg.css">
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="./JS/jquery.star-rating-svg.js"></script>
    <link rel="icon" type="image/png" href="./img/icono.png">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img//Logo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article><b>QUETZUAL</b></article>
            <div class="menu">
                <a href="./sesionUsuario.jsp">
                    <img src="./img/bx-home.png" alt="Imagen ">
                </a>
                <a href="./preguntasPendientes.jsp">
                    <img src="./img/bx-question-mark.png" alt="Signo de pregunta" class="svg">
                </a>
                <a href="./cuenta.jsp">
                    <img src="./img/bx-user-circle.png" width="40" alt="Signo de pregunta" class="svg">
                </a>
                <a href="./CerrarSesion">
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
        <h1>Preguntas Similares</h1>
        <hr>
    </div>
    <a href="HacerPregunta" class="hacer">Hacer Pregunta</a>
    <% 
            for(MPregunta pres: simi){
        %>
    <div class="main_container">
        <div class="mini_header">
            <h2><%=pres.getEdad_usu() %> Años</h2>
            <h2><% 
                 if(pres.getId_catgen() == 1){
                 %>Enfermedades de transmisión sexual<%
                 }else if(pres.getId_catgen() == 2){
                 %>Embarazo<%
                 }else if(pres.getId_catgen() == 3){
                 %>Salud sexual femenina<%
                 }else if(pres.getId_catgen() == 4){
                 %> Salud sexual masculina<%
                 }else if(pres.getId_catgen() == 5){
                 %>Anticonceptivos <%
                 }
               
                %></h2>
            <h2><%=pres.getCantidadRes() %> respuestas</h2>
        </div>
        
        <div class="pregunta">
            <img src="./img/bxs-user.svg" alt="">
            <div class="preguntas">
                <h3><%=pres.getDes_pre()%></h3>
            </div>
        </div>
        <div class="respuesta">
            <a href="./respuestasPregunta.jsp?id=<%=pres.getId_pre() %>">Ver respuestas</a>
        </div>
        
    </div>
    <% 
            }
        %>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal2.js"></script>
</body>

</html>