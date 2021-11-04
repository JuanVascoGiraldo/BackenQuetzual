
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
        response.sendRedirect("index.jsp");
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
    <title>Preguntar</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/hacerPregunta.css">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
    <header class=" header ">
        <nav class="navegacion ">
            <img src="./img/logotipo.png " alt="Logotipo oficial de Quetzual " class="logo ">
            <article>Mis preguntas</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./sesionUsuario.jsp">
                <img src="./img/bx-home.svg" alt="Imagen inicio"> Inicio
            </a>
            <a href="./cuenta.jsp">
                <img src="./img/bx-user-circle.svg" width="40" alt="Signo de pregunta" class="svg"> Mi cuenta
            </a>
            <a href="./preguntasPendientes.jsp">
                <img src="./img/bx-question-mark.svg " alt="Simbolo de pregunta"> Mis preguntas
            </a>
        </div>
    </header>
    <div class="title">
        <h1>Hacer Pregunta</h1>
        <hr>
        <p class="p">En este espacio puedes realizar una petición para que el doctor resuelva tu duda</p>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option selected disabled hidden>Selecciona el filtro de preguntas</option>
            <option value="./hacerPregunta.html">Hacer pregunta</option>
            <option value="./preguntasRespondidas.jsp">Preguntas Respondidas</option>
            <option value="./preguntasRechazadas.jsp">Preguntas rechazadas</option>
            <option value="./preguntasPendientes.jsp">Preguntas pendientes</option>
        </select>
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
                <button class="question" onclick="HPregunta()">Preguntar</button>
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