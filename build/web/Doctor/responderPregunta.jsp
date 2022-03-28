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
        %> 
        <jsp:forward page="index.jsp">
        <jsp:param name="Error" value="Es obligatorio identificarse" />
         </jsp:forward>
<%
    }
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    int id = 0; 
    try{
        id= Integer.valueOf(request.getParameter("id"));
    }catch(Exception e){
        response.sendRedirect("./preguntasPendientes.jsp");
    }
    MPregunta pre = GestionarPregunta.ConsultarPres(id, usu.getClave());
    if(pre.getDes_pre().equals("no encontrada")){
         response.sendRedirect("./preguntasPendientes.jsp");
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
    <title>Responder</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/responderPregunta.css">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
    <h1 style="text-align:center">Responder Pregunta</h1>

    
    <a href="./preguntasPendientes.jsp" class="enlace">
        <div class="title" onclick="enviarGestionarPreguntas()">
            <img src="./img/bxs-left-arrow-circle.svg">
            <h1>Volver a gestionar preguntas</h1>
        </div>
    </a>
    <form name="Rpregunta" action="../ResponderPregunta">
        <div class="main_container">
            <div class="mini_header2">
                <h2><%=pre.getFecha_pre()%></h2>
                <input type="hidden" value="<%=pre.getFecha_pre() %>" name="fecha_pre">
            </div>
            <div class="pregunta2">
                <h1>Pregunta</h1>
            </div>
            <div class="pregunta">
                <input type="hidden" value="<%=pre.getId_pre() %>" name="id_pre">
                <textarea name="des_pre" id="pregunta" class="area" placeholder="Escribe aquí tu pregunta"><%=pre.getDes_pre() %></textarea>
            </div>
            <select name="id_cat" id="filtro">
                <option value="1" selected>Enfermedades de transmisión sexual</option>
                <option value="5">Anticonceptivos</option>
                <option value="2">Embarazo</option>
                <option value="3">Salud sexual femenina</option>
                <option value="4">Salud sexual masculina</option>
            </select>
            <div class="pregunta2">
                <h1>Respuesta</h1>
            </div>
            <div class="pregunta">
                <textarea name="des_res" id="respuesta" class="area" placeholder="Escribe aquí tu respuesta"></textarea>
            </div>
            <div class="flex">
                <button type="button" id="responder" class="question" onclick="ResPregunta()">Responder</button>
                <a href="./preguntasPendientes.jsp" class="enlace"><button class="cs">Cancelar</button></a>
            </div>
        </div>
    </form>
    <div class="modal" id="modalR">
        <div class="card">
            <h1>¡Felicidades!</h1><br>
            <h1>Has obtenido puntos por responder esta pregunta</h1><br>
            <h1>Gracias por tu esfuerzo</h1><br>
            <img src="./img/undraw_happy_announcement_ac67.svg" class="img">
        </div>
    </div>
    <script src="./JS/funcionModal.js"></script>
    <script src="./JS/redirigir.js"></script>
    <script src="./JS/validar.js"></script>
</body>
</html>
