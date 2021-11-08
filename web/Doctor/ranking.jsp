

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
        response.sendRedirect("../index.jsp");
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
        usuarios = GestionarUsuario.ObtenerRankingHistorico(usu.getClave());
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
    <title>Ranking</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/ranking.css">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img/logotipo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article>Ranking</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./inicioDoctor.jsp">
                <img src="./img/bx-home.svg" alt="Simbolo de usuario " class="svg "> Inicio
            </a>
            <a href="./cuentaDoctor.jsp">
                <img src="./img/bx-user-circle.svg" width="40" alt="Signo de pregunta" class="svg"> Mi cuenta
            </a>
            <a href="./preguntasPendientes.jsp">
                <img src="./img/bx-edit.svg" alt="Imagen "> Gestionar preguntas
            </a>
        </div>
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
            <option value="ranking.jsp?fil=0">General</option>
            <option value="ranking.jsp?fil=1">Mensual</option>
        </select>
    </div>
    <div class="main_container">
        <div class="grid">
            <div class="encabezado">
                <div class="doctores">Doctores</div>
                <div class="puntos">Puntos</div>
            </div>
            <% 
                int total = 0;
                int i = 0;
                for(MUsuario usua:usuarios){
                    i++;
                    total++;
                    if(i > 3){ 
                        %>
                        <div class="participante">
                            <div class="doctores"><%=i%>. <%=usua.getNom_usu() %></div>
                            <div class="puntos"><%=usua.getPuntos() %> 🏆</div>
                        </div>
            <%
                    }else if(i == 3){
                    %>
                    <div class="tercero">
                        <div class="doctores"><%=i%>. <%=usua.getNom_usu() %></div>
                        <div class="puntos"><%=usua.getPuntos() %> 🏆</div>
                    </div>
            
            <%
                    }else if(i == 2){
                    %>
                    <div class="segundo">
                        <div class="doctores"><%=i%>. <%=usua.getNom_usu() %></div>
                        <div class="puntos"><%=usua.getPuntos() %> 🏆</div>
                    </div>
            
            <%
                    }else if(i == 1){
                    
                    
            %>
                    <div class="primero">
                        <div class="doctores"><%=i%>. <%=usua.getNom_usu() %></div>
                        <div class="puntos"><%=usua.getPuntos() %> 🏆</div>
                    </div>
            <% }}
                %>
        </div>
               <% 
                if(total == 0){
        %> 
        <div class="vacio">
            <p>No hay Ranking <%if(fil==0){%>Historico <% }else if(fil==1){%>Mensual <% } %>Actualmente</p>
            <img src="./img/sinrakmen.svg">
        </div>
    <%
        }
    %>
    </div>
    <div class="main_container">
        <script src="./JS/redirigir.js"></script>
</body>

</html>

