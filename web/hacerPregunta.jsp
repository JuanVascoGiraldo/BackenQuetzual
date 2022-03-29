<%@page import="java.util.Calendar"%>
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
    Calendar fecha = java.util.Calendar.getInstance();
    String fech=fecha.get(java.util.Calendar.DATE) + "/"
        + (fecha.get(java.util.Calendar.MONTH)+1) + "/" 
                + fecha.get(java.util.Calendar.YEAR);

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
    <title>Preguntar</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/hacerPregunta.css">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
        <h1>Hacer Pregunta</h1>
        <hr>
        <p class="p">En este espacio puedes realizar una petición para que el doctor resuelva tu duda</p>
    </div>
    <div class="main_container">
        <div class="mini_header2">
            <h2><%=fech %></h2>
        </div>
        <form action="PreguntasSimilares" name="HacerP">
            <div class="pregunta">
                <img src="./img/bxs-user.svg" alt="">
                <textarea name="pregunta" id="pregunta" class="area" placeholder="Escribe aquí tu pregunta"></textarea>
            </div>
            <div class="flex">
                <!--<button class="question" onclick="HPregunta()">Preguntar</button>-->
                <button type="button" class="question" onclick="HPregunta()">Preguntar</button>
                <button class="cs" onclick="javascript:location.href ='./sesionUsuario.jsp'">Cancelar</button>
            </div>
        </form>
    </div>
    <script src="./JS/algoritmoDeDestruccionGatuna.js"></script>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>

</html>