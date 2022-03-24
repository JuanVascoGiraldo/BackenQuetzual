<%@page import="java.util.List"%>
<%@page import="Control.GestionarPregunta"%>
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
        id = Integer.valueOf(request.getParameter("id"));
    }catch(Exception e){
        response.sendRedirect("preguntasDoctor.jsp");
    }
    List<MRespuesta> lista = GestionarPregunta.ConsultarRespuestas(id, usu.getClave());
    
    if(lista.size() == 0){
        response.sendRedirect("preguntasDoctor.jsp");
    }
    boolean yares = false;
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Respuestas</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/sesionUsuario.css">
    <link rel="stylesheet" href="./CSS/star-rating-svg.css">
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="./JS/jquery.star-rating-svg.js"></script>
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
    <h1 style="text-align:center">Respuesta preguntas</h1>
    <a href="./preguntasPendientes.jsp">
        <img src="./img/bxs-left-arrow.svg" alt="Imagen"> Volver
    </a>

    <% 
        for(MRespuesta res:lista){
            if(res.getId_usuRes() == usu.getId_usu())yares = true;
    %>
    <div class="main_container">
        <div class="mini_header">
            <h2>Dr. <%=res.getNom_doc()%></h2>
            <h2><%=res.getFecha_res() %> </h2>
        </div>
        <div class="sub_header">
            <h2><%=res.getCali_pro() %><p class="star">★</p> </h2>
        </div>
        <div class="respuesta">
            <div class="respuestas">
                <h3><%=res.getDes_res() %></h3>
            </div>
            <img src="./img/bx-plus-medical.svg" alt="">
        </div>
    </div>
     <% 
        }
        if(!yares){
     %>
    <form class="alineacion" action="../Respre" name="responder">
        <div class="pregunta">
            <textarea name="des_res" id="respuestas" class="area" placeholder="Escribe aquí tu respuesta"></textarea>
        </div>
        <input type="hidden" name="id_pre" value="<%=id %>" >
        <button type="button" onclick="agregarRespuestares()" class="submit">Agregar respuesta</button>
    </form>
        <% 
            }
        %>
    
    <div class="modal" id="modalR">
        <div class="card">
            <h1>¡Felicidades!</h1><br>
            <h1>Has obtenido puntos por responder esta pregunta</h1><br>
            <h1>Gracias por tu esfuerzo</h1><br>
            <img src="./img/undraw_happy_announcement_ac67.svg" class="img">

            <button class="question" onclick="enviarGestionarPreguntas()">Aceptar</button>
        </div>
    </div>  
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>

</html>
