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
        response.sendRedirect("../index.jsp");
    }
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    int id = 0;
    try{
        id = Integer.valueOf(request.getParameter("id"));
    }catch(Exception e){
        response.sendRedirect("preguntasDoctor.jsp");
    }
    List<MRespuesta> lista = GestionarPregunta.ConsultarRespuestas(id, usu.getClave());
    System.out.println(lista.size());
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
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img/logotipo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article>Respuestas</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./preguntasDoctor.jsp">
                <img src="./img/bxs-left-arrow.svg" alt="Imagen"> Volver
            </a>
        </div>
    </header>
    <% 
        for(MRespuesta res:lista){
            if(res.getId_usuRes() == usu.getId_usu())yares = true;
    %>
    <div class="main_container">
        <div class="mini_header">
            <h2><%=res.getNom_doc()%></h2>
            <h2><%=res.getFecha_res() %> </h2>
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
        <button onclick="agregarRespuestares()" class="submit">Agregar respuesta</button>
    </form>
        <% 
            }
        %>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>

</html>
