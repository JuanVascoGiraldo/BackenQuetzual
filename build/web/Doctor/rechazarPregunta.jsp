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
    <title>Rechazar Pregunta</title>
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
                <a href="./inicioDoctor.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Inicio</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="./cuentaDoctor.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Cuenta</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="./ranking.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Ranking</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="../CerrarSesion" style="margin-right: 2%; margin-left: 2%;">
                    <img src="./img/salir.png" alt="Signo de pregunta" class="svg">
                </a>
                &nbsp;
                &nbsp;

            </div>
        </nav>
    </header>
    <h1 style="text-align:center">Rechazar Pregunta</h1>
    <a href="./preguntasPendientes.jsp" class="enlace">
        <div class="title">
            <img src="./img/bxs-left-arrow-circle.svg">
            <h1>Volver a gestionar preguntas</h1>
        </div>
    </a>
    <div class="main_container">
        <form action="../RechazarPre" name="rechazarPre">
            <div class="mini_header2">
                <h2><%=pre.getFecha_pre() %></h2>
            </div>
            <div class="pregunta2">
                <h1>Pregunta</h1>
            </div>
            <div class="pregunta">
                <h3><%=pre.getDes_pre() %></h3>
            </div>
            <div class="pregunta2">
                <h1>??Cu??l es el motivo del rechazo?</h1>
            </div>
            <div class="pregunta">
                <input type="hidden" name="id_pre" value="<%=pre.getId_pre() %>" >
                <textarea name="razon" id="razon" class="area" placeholder="Escribe aqu?? tu motivo de rechazo"></textarea>
            </div>
            <div class="flex">
                <button type="button" id="rechazar" class="question" onclick="RechaPregunta()">Confirmar</button>
                <a href="./preguntasPendientes.jsp" class="enlace"><button class="cs">Cancelar</button></a>
            </div>
        </form>
    </div>
    <div class="modal" id="modalR">
        <div class="card">
            <h1>Cuidado, esta acci??n ser?? permanente, una vez que rechace la pregunta los datos no podr??n recuperarse.</h1><br>
            <h1>??Desea continuar?</h1><br>
            <button class="cs" onclick="conf()">Rechazar pregunta</button><br>
            <button class="question">No, deseo mantener la pregunta</button>
        </div>
    </div>
    <script>
        var socket1 = new WebSocket("wss://quetzual.herokuapp.com/Responder");
        function conf(){
            socket1.send("Rechazada");
            document.rechazarPre.submit();
        }
    </script>
    <script src="./JS/redirigir.js"></script>
    <script src="./JS/funcionModal.js"></script>
    <script src="./JS/validar.js"></script>
</body>

</html>
