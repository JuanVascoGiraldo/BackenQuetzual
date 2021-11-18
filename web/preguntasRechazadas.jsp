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
        <jsp:forward page="paginaError2.html">
        <jsp:param name="Error" value="Es obligatorio identificarse" />
         </jsp:forward>
<%
    }
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    List<MPublicacion> lista = GestionarPregunta.ConsultarPreRecUsu(usu.getId_usu(), usu.getClave(), usu.getToken());
   
    
%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Preguntar</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/preguntasRechazadas.css">
    <link rel="icon" type="image/png" href="./img/icono.png">
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
            <a href="./hacerPregunta.jsp">
                <img src="./img/bx-edit-alt.svg" alt="Signo de editar" class="svg"> Quiero preguntar
            </a>
        </div>
    </header>
    <div class="title">
        <h1>Preguntas rechazadas</h1>
        <hr>
        <p>En este espacio puedes consultar las preguntas que han sido rechazadas por los doctores.</p>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option selected disabled hidden>Selecciona el filtro de preguntas</option>
            <option value="./hacerPregunta.jsp">Hacer pregunta</option>
            <option value="./preguntasRespondidas.jsp">Preguntas Respondidas</option>
            <option value="./preguntasRechazadas.jsp" selected>Preguntas rechazadas</option>
            <option value="./preguntasPendientes.jsp">Preguntas pendientes</option>
        </select>
    </div>
    <% 
        for(MPublicacion publi: lista){
            MPregunta pre = publi.getPregunta();
            MRespuesta res = publi.getRespuesta();
    %> 
    <div class="card">
        <div class="mini_header">
            <h2><%=res.getFecha_res() %></h2>
        </div>
        <div class="pregunta">
            <img src="./img/bxs-user.svg" alt="">
            <div class="preguntas">
                <h3><%=pre.getDes_pre() %></h3>
            </div>
            <h1 class="h1">Razón del rechazo</h1>
            <div class="preguntas">
                <h3><%=res.getDes_res() %></h3>
            </div>
        </div>
    </div>
    <% 
        }
        if(lista.size() == 0){
    %> 
    
    <div class="vacio">
            <p>No Tienes Preguntas Rechazadas Actualmente</p>
            <img src="./img/sinprerechusu.svg">
        </div>
    <% } %>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
</body>

</html>