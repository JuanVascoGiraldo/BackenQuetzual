

<%@page import="java.util.List"%>
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
    List<MPublicacion> publi= GestionarPregunta.ConsultatHistoricoDoc(usu.getId_usu(), usu.getClave());
    int fil = 0;
    try{
        fil = Integer.valueOf(request.getParameter("fil"));
        if(fil == 1 || fil>4){
            response.sendRedirect("cuentaDoctor.jsp?fil=0");
        }
    }catch(Exception e){
        response.sendRedirect("cuentaDoctor.jsp?fil=0");
    }
    
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/cuentaDoctor.css">
    <link rel="stylesheet" href="./CSS/star-rating-svg.css">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img/logotipo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article>Mi cuenta</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./inicioDoctor.jsp">
                <img src="./img/bx-home.svg" alt="Imagen inicio"> Inicio
            </a>
            <a href="./preguntasPendientes.jsp">
                <img src="./img/bx-edit.svg" alt="Imagen "> Gestionar preguntas
            </a>
            <a href="./ranking.jsp">
                <img src="./img/bx-line-chart.svg" alt="Signo de editar" class="svg"> Ranking
            </a>
        </div>
    </header>

    <div class="title">
        <h1><%if(fil == 0){%>Todas las Preguntas<%}else if(fil == 2){%>Preguntas Respondidas<%}else if(fil == 3){%>Preguntas Rechazadas<%} %></h1>
        <hr>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option selected disabled hidden>Selecciona el filtro de preguntas</option>
            <option value="cuentaDoctor.jsp?fil=0">Todas Las Preguntas</option>
            <option value="cuentaDoctor.jsp?fil=3">Preguntas Rechazadas</option>
            <option value="cuentaDoctor.jsp?fil=2">Preguntas Respondidas</option>
        </select>
    </div>
    <% 
        int total = 0;
        for(MPublicacion pu: publi){
            MPregunta pre = pu.getPregunta();
            MRespuesta res = pu.getRespuesta();
            
            if(((fil == 0 && pre.getId_estado() == 2) || (fil == pre.getId_estado()))&& res.getId_cat() != 6){
                total++;
    %>
    <div class="card">
        <div class="main_container">
            <div class="mini_header">
                <h2><%=pre.getEdad_usu() %> años</h2>
                <h2><% 
                 if(res.getId_cat() == 1){
                 %>Enfermedades de transmisión sexual<%
                 }else if(res.getId_cat() == 2){
                 %>Embarazo<%
                 }else if(res.getId_cat() == 3){
                 %>Salud sexual femenina<%
                 }else if(res.getId_cat() == 4){
                 %> Salud sexual masculina<%
                 }else if(res.getId_cat() == 5){
                 %>Anticonceptivos <%
                 }
               
                %></h2>
                <h2><%=res.getCali_pro() %>
                    <p class="star">★</p>
                </h2>
            </div>
            <div class="sub_header">
                <h2><%=pre.getFecha_pre() %> - Respondido: <%=res.getFecha_res() %></h2>
                <h2>Dr. <%=usu.getNom_usu()%></h2>
            </div>
            <div class="pregunta">
                <img src="./img/bxs-user.svg" class="img">
                <div class="preguntas">
                    <h3><%=pre.getDes_pre()%></h3>
                </div>
            </div>
            <div class="respuesta">
                <div class="respuestas">
                    <h3><%=res.getDes_res() %></h3>
                </div>
                <img src="./img/bx-plus-medical.svg" class="img">
            </div>
        </div>
    </div>
    <% 
        } 
    if(((fil == 0 && pre.getId_estado() == 3) || (fil == pre.getId_estado() )) && res.getId_cat() == 6){
        total++;
    %>
    <div class="card">
        <div class="mini_header2">
            <h2><%=res.getFecha_res() %></h2>
        </div>
        <div class="pregunta2">
            <img src="./img/bxs-user.svg" alt="">
            <div class="preguntas2">
                <h3><%=pre.getDes_pre()%></h3>
            </div>
            <h1 class="h1">Razón del rechazo</h1>
            <div class="preguntas2">
                <h3><%=res.getDes_res() %></h3>
            </div>
        </div>
    </div>
    <% 
        }
    }
        if(total == 0){
        %> 
        <div class="vacio">
            <p>No hay Preguntas<%if(fil == 2){%> Respondidas <% }else if(fil == 3){%> Rechazadas <%  }%>en el Historico</p>
            <img src="./img/sinhis.svg">
        </div>
    <%
        }
    %>
    <script src="./JS/redirigir.js"></script>
</body>

</html>
