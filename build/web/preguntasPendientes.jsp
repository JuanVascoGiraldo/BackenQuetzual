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
        response.sendRedirect("index.jsp");
    }
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    List<MPregunta> pre = GestionarPregunta.ConsultarPrePenUsu(usu.getId_usu(), usu.getClave());
    if(pre.size() == 0){
        response.sendRedirect("hacerPregunta.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Preguntas Pendientes</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/preguntasPendientes.css">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img/logotipo.png" alt="Logotipo oficial de Quetzual" class="logo">
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
        <h1>Preguntas Pendientes</h1>
        <hr>
        <p>En este espacio puedes consultar tus preguntas que están en espera de recibir respuesta</p>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option selected disabled hidden>Selecciona el filtro de preguntas</option>
            <option value="./hacerPregunta.jsp">Hacer pregunta</option>
            <option value="./preguntasRespondidas.jsp">Preguntas Respondidas</option>
            <option value="./preguntasRechazadas.jsp">Preguntas rechazadas</option>
            <option value="./preguntasPendientes.jsp">Preguntas pendientes</option>
        </select>
    </div>
    <% 
        for(MPregunta pres: pre){
    
    %>
    <div class="main_container">

        <div class="mini_header">
            <h2>Pendiente</h2>
        </div>
        <div class="sub_header">
            <h2><%=pres.getFecha_pre() %> - Respondido: Por definir</h2>
            <h2>Dr. Por Definir</h2>
        </div>
        <div class="flex">
            <div class="pregunta">
                <img src="./img/bxs-user.svg" alt="">
                <div class="preguntas">
                    <p class="text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=pres.getDes_pre() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                </div>
            </div>
            <div class="pregunta">
                <button class="cs" onclick="redeliminar(<%=pres.getId_pre()%>)">Eliminar pregunta</button>
                <button class="question" data-open="modalR" onclick="redModi(<%=pres.getId_pre() %>)" >Modificar Pregunta</button>
            </div>
        </div>
        <div class="pregunta2">
            <div class="preguntas2">
                <p class="text">
                    ...
                </p>
            </div>
            <img src="./img/bx-plus-medical.svg" alt="">
        </div>
    </div>
    <%
        }
    %>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script>
        function redeliminar(id){
                    location.href='./EliminarPre?id='+id 
                }
        function redModi(id){
            location.href='./modificarPregunta.jsp?id='+id 
        }        
    </script>
</body>

</html>
