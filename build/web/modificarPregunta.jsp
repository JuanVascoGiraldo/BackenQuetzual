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
        <jsp:forward page="index.jsp">
        <jsp:param name="Error" value="Es obligatorio identificarse" />
         </jsp:forward>
<%
    }
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    int id = 0; 
    try{
        id= Integer.valueOf(request.getParameter("id"));
    }catch(Exception e){
        response.sendRedirect("./preguntasPendientes.jsp");
    }
    MPregunta pre = GestionarPregunta.ConsultarPres(id, usu.getClave());
    if(pre.getDes_pre().equals("no encontrada")){
        response.sendRedirect("./preguntasPendientes.jsp");
    }else if(pre.getId_usup() != usu.getId_usu()){
        response.sendRedirect("./preguntasPendientes.jsp");
    }

%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <% 
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <title>Modificar Pregunta</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/modificarPregunta.css">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="icon" type="image/png" href="./img/icono.png">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img//Logo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article><b>QUETZUAL</b></article>
            <div class="menu">
                <a href="./sesionUsuario.jsp">
                    <img src="./img/bx-home.png" alt="Imagen ">
                </a>
                <a href="./cuenta.jsp">
                    <img src="./img/bx-user-circle.png" width="40" alt="Signo de pregunta" class="svg">
                </a>
                <a href="./hacerPregunta.jsp">
                    <img src="./img/bx-edit-alt.png" alt="Signo de editar" class="svg">
                </a>
                <a href="CerrarSesion">
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
        <h1>Modificar Pregunta</h1>
        <hr>
        <p>En este espacio puedes modificar tu pregunta en caso de que te hayas equivocado y quieras cambiarla.</p>
    </div>
    <div class="main_container">
        <form action="modiPre" name="ModificarPre">
            <div class="mini_header">
                <h2></h2>
                <h2>Pendiente</h2>
            </div>
            <input type="hidden" value="<%=pre.getId_pre() %>" name="id" >
            <div class="sub_header">
                <h2><%=pre.getFecha_pre() %> - Respondido: Por definir</h2>
                <h2>Esperando Doctor</h2>
            </div>
            <div class="pregunta">
                <img src="./img/bxs-user.svg" alt="">
                <textarea name="pre" id="Mpregunta" class="area" placeholder="Escribe aquí tu pregunta"><%=pre.getDes_pre() %></textarea>
            </div>
            <div class="flex">
                <button type="button" class="cs" data-open="modalR" onclick="redeliminar(<%=pre.getId_pre() %>)">Eliminar pregunta</button>
                <button type="button" class="question" onclick="MPregunta()">Guardar cambios</button>
            </div>
        </form>
    </div>
    <div class="modal" id="modalR">
        <div class="card">
            <article>
                <b>
                    Cuidado, esta acción será permanente, una vez eliminada la pregunta todos los datos no podrán recuperarse.¿Desea continuar?
                </b>
            </article>
            <button class="cs">Eliminar pregunta</button> <br>
            <button class="question" onclick="crm()">No, quiero volver</button>
        </div>
    </div>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
    <script>
        var socket2 = new WebSocket("wss://quetzual.herokuapp.com/Pregunta");
        function redeliminar(id){
                    socket2.send("Eliminada"); 
                    location.href='./EliminarPre?id='+id
            }      
    </script>
</body>

</html>
