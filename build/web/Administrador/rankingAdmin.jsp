<%@page import="java.util.Calendar"%>
<%@page import="Control.GestionarUsuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
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
    <title>Ranking</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/rankingAdmin.css">
    <link rel="icon" type="image/png" href="./img/icono.png">
</head>

<body>
    <button class="menu" data-open="modalR"><img src="./img/bx-menu (2).svg"></button>
    <h1>Mejores desempeños</h1>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option selected disabled hidden>Filtrar por fecha</option>
            <option value="1" >General</option>
            <option value="2" >Mensual</option>
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
            <!--<% 
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
            <% 
                }}
            
        %>
        </div>
        <% 
    -->
    <!--
        if(total == 0){
        %> 
        <div class="vacio">
            <p>No hay Ranking <%if(fil==0){%>Historico <% }else if(fil==1){%>Mensual <% } %>Actualmente</p>
            <img src="./img/sinrakmen.svg">
        </div>
        <%
            }
        %>
        -->
    </div>
    <div class="modal" id="modalR">
        <aside class="modal-dialog">
            <img src="./img/LogoBlancoLetrasSinFondo.png">
            <button onclick="enviarSesionAdmin()">Inicio</button>
            <button onclick="enviarCuentaAdmin()">Cuenta</button>
            <button onclick="enviarAdminDoctores()">Administrar Doctores</button>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </aside>
    </div>
    <script src="./JS/redirigir.js"></script>
    <script src="./JS/funcionModal2.js"></script>
</body>

</html>