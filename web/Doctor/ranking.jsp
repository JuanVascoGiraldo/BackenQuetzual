<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="Control.GestionarUsuario"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
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
    int fil=0;
    try{
        fil = Integer.valueOf(request.getParameter("fil"));
    }catch(Exception e){
        fil = 0;
    }
    List<MUsuario> usuarios = new ArrayList<MUsuario>();
    if(fil == 0){
        usuarios = GestionarUsuario.ObtenerRankingHistorico(usu.getClave(), usu.getToken());
    }else if(fil == 1){
        Calendar fecha = java.util.Calendar.getInstance();
        String fech=(fecha.get(java.util.Calendar.MONTH)+1) + "/" 
                    + fecha.get(java.util.Calendar.YEAR);
        usuarios = GestionarUsuario.ObtenerRankingMensual(fech, usu.getClave());
    }
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
    <title>Ranking</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/ranking.css">
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
                <a href="./preguntasPendientes.jsp">
                    <img src="./img/bx-edit.png" alt="Imagen ">
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


    <div class="title">
        <h1>Mejores desempeños</h1>
        <hr>
        <p>En este espacio puedes consultar el ranking de los doctores que al igual que tu han colaborado a orientar al usuario y que han destacado en base a los puntos obtenidos.</p>
        <p>Puedes consultarlo de forma general o mensual.</p>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option selected disabled hidden>Filtrar por fecha</option>
            <option value="1"  >General</option>
            <option value="2"  >Mensual</option>
        </select>
    </div>
    <div class="main_container">
        <div class="grid">
            <div class="encabezado">
                <div class="doctores">Doctores</div>
                <div class="puntos">Puntos</div>
            </div>
            <div id="cambiar">
                <div class="primero">
                    <div class="doctores">Dr.Gutierrez Bueno</div>
                    <div class="puntos">20 🏆</div>
                </div>
                <div class="segundo">
                    <div class="doctores">Dr.Maya Caltenco</div>
                    <div class="puntos">19 🏆</div>
                </div>
                <div class="tercero">
                    <div class="doctores">Dr.Giron Flores</div>
                    <div class="puntos">18 🏆</div>
                </div>
                <div class="participante">
                    <div class="doctores">Dr.Salvador Campos</div>
                    <div class="puntos">17 🏆</div>
                </div>
                <div class="participante">
                    <div class="doctores">Dr.Vasco Giraldo</div>
                    <div class="puntos">1 🏆</div>
                </div>
            </div>
           
    <div class="main_container">
        <script src="./JS/redirigir.js"></script>
</body>

</html>

