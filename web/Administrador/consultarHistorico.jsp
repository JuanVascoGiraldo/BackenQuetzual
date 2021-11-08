<%@page import="java.util.List"%>
<%@page import="Control.GestionarPregunta"%>
<%@page import="Control.GestionarPregunta"%>
<%@page import="Control.GestionarUsuario"%>
<%@page import="Modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java"%>

<% 
    HttpSession sesion = request.getSession(true);
    if(sesion.getAttribute("usuario") != null){
        MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
        if(usu.getId_rol() != 3){
            response.sendRedirect("../index.jsp");
        }
    }else{
        response.sendRedirect("../index.jsp");
    }
    MUsuario usua = (MUsuario)sesion.getAttribute("usuario");
    int id = 0; 
    try{
        id= Integer.valueOf(request.getParameter("id"));
    }catch(Exception e){
        response.sendRedirect("./adminDoctores.jsp");
    }
    MUsuario usu = GestionarUsuario.consultarDoctor(id, usua.getClave());
    String nombre = usu.getNom_usu();
    
    if(nombre.equals("no encontrado")){
        response.sendRedirect("./adminDoctores.jsp");
    }
    List<MPublicacion> publi= GestionarPregunta.ConsultatHistoricoDoc(id, usua.getClave());
    int fil = 0;
    try{
        fil = Integer.valueOf(request.getParameter("fil"));
        if(fil == 1 || fil>4){
            response.sendRedirect("consultarHistorico.jsp?fil=0&&id="+id);
        }
    }catch(Exception e){
        fil = 0;
    }
%>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/consultarHistorico.css">
</head>

<body>
    <button class="menu" data-open="modalR"><img src="./img/bx-menu (2).svg"></button>
    <h1>Historico</h1>
    <div class="title">
        <h2>Dr. <%=usu.getNom_usu()%></h2><br>
        <hr>
    </div>
    <div class="flex">
        <button onclick="enviarAdminDoctores()"><img src="./img/bxs-left-arrow.svg" class="img">Volver</button>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option selected disabled hidden>Selecciona el filtro de preguntas</option>
            <option value="consultarHistorico.jsp?fil=0&&id=<%=id%>">Todas Las Preguntas</option>
            <option value="consultarHistorico.jsp?fil=3&&id=<%=id%>">Preguntas Rechazadas</option>
            <option value="consultarHistorico.jsp?fil=2&&id=<%=id%>">Preguntas Respondidas</option>
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
            <p>No hay Preguntas<%if(fil == 2){%> Respondidas <% }else if(fil == 3){%> Rechazadas<%  }%> en el Historico</p>
            <img src="./img/sinhis.svg">
        </div>
    <%
        }
    %>
   
    <div class="modal" id="modalR">
        <aside class="modal-dialog">
            <img src="./img/logotipo.png">
            <button onclick="enviarSesionAdmin()">Inicio</button>
            <button onclick="enviarCuentaAdmin()">Cuenta</button>
            <button onclick="enviarRankingAdmin()">Ranking</button>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </aside>
    </div>
    <script src="./JS/redirigir.js"></script>
    <script src="./JS/funcionModal.js"></script>
    <script src="./JS/validar.js"></script>
    <div class="modal" id="modalR">
        <div class="card">
            <article>
                <h2>La Cuenta ha sido modificada con exito</h2>
            </article>
            <img src="./img/check-square-solid-240.png" alt="">
        </div>
    </div>
</body>
</html>
