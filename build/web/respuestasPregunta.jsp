<%@page import="java.util.List"%>
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
        <jsp:forward page="paginaError2.html">
        <jsp:param name="Error" value="Es obligatorio identificarse" />
         </jsp:forward>
<%
    }
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    int id = 0;
    try{
        id = Integer.valueOf(request.getParameter("id"));
    }catch(Exception e){
        response.sendRedirect("sesionUsuario.jsp");
    }
    List<MRespuesta> lista = GestionarPregunta.ConsultarRespuestas(id, usu.getClave());
    
    if(lista.size() == 0){
        response.sendRedirect("sesionUsuario.jsp");
    }
    
    int re = 0;
    try{
        re = Integer.valueOf(request.getParameter("re"));
    }catch(Exception e){
        re = 0;
    }
    String redireccionar = "";
    if(re == 0){
        redireccionar = "sesionUsuario.jsp";
    }else{
        redireccionar = "preguntasRespondidas.jsp";
    }
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
    <link rel="icon" type="image/png" href="./img/icono.png">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img/logotipo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article>Respuestas</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./<%=redireccionar %>">
                <img src="./img/bxs-left-arrow.svg" alt="Imagen"> Volver
            </a>
        </div>
    </header>
    
    <% 
        for(MRespuesta res:lista){
    %>
    <div class="main_container">
        <div class="mini_header">
            <h2>Dr. <%=res.getNom_doc() %></h2>
            <h2><%=res.getFecha_res() %> </h2>
        </div>
        <div class="sub_header">
                <h2><% 
                        int cal = GestionarPregunta.caliRes(usu.getId_usu(), res.getId_res(), usu.getClave(), usu.getToken());
                        if(cal >0){
                %> 
                        Calificada con <%=cal %><p class="star">★</p> </h2>
                    <%     
                        }else if(cal == 0){
                        %> 
                        No ha Dado una Calificación
            <%
                        }
                    %></h2>
        <h2><%=res.getCali_pro() %><p class="star">★</p> </h2>
        </div>
        <div class="respuesta">
            <div class="respuestas">
                <h3><%=res.getDes_res() %></h3>
            </div>
            <img src="./img/bx-plus-medical.svg" alt="">
        </div>
        <div class="calificacion">
            <div class="contenedor">
                <div class="p"><% if(cal == 0){ %>¿Te ha resultado útil esta solución? <% }else{%>Cambia la Calificación dada<%} %> </div>
                <div class="Estrellas" id="Estrellas" onclick="calificar(<%=id%>,<%=res.getId_res()%>,<%=re%>)"></div>
            </div>
        </div>
    </div>
    <% 
        }
    %>
    <div class="modal" id="modalR">
        <div class="card">
            <article>
                <b>Tu Calificación ha sido registrada</b>
            </article>
            <img src="./img/check-square-solid-240.png" alt="" onclick="crm()" class="cubitoVerde">
        </div>
    </div>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>

</html>
