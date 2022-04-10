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
        <jsp:forward page="index.jsp">
        <jsp:param name="Error" value="Es obligatorio identificarse" />
         </jsp:forward>
<%
    }
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    List<MPregunta> pre = GestionarPregunta.ConsultarPrePenUsu(usu.getId_usu(), usu.getClave(), usu.getToken());
    
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
    <title>Preguntas Pendientes</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/preguntasPendientes.css">
    <link rel="stylesheet" href="./CSS/preguntasRechazadas.css">
    <link rel="stylesheet" href="./CSS/preguntasRespondidas.css">
    <link rel="icon" type="image/png" href="./img/icono.png">
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img//Logo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article><b>QUETZUAL</b></article>
            <div class="menu">
                <a href="./sesionUsuario.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Inicio</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="./cuenta.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Cuenta</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="./hacerPregunta.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Preguntar</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="CerrarSesion" style="margin-right: 2%; margin-left: 2%;">
                    <img src="./img/salir.png" alt="Signo de pregunta" class="svg">
                </a>
                &nbsp;
                &nbsp;
            </div>
        </nav>
    </header>
    <h1 style="text-align:center">Mis Preguntas</h1>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:filtrar(this.value)">
            <option disabled hidden>Selecciona el filtro de preguntas</option>
            <option value="1">Preguntas Respondidas</option>
            <option value="2">Preguntas rechazadas</option>
            <option value="3" selected>Preguntas pendientes</option>
        </select>
    </div>
    <div id="cambiar">
    
        
    </div>

    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script>
        var socket1 = new WebSocket("wss://quetzual.herokuapp.com/Pregunta");
        function redeliminar(id){
                socket1.send("Eliminada");
                location.href='./EliminarPre?id='+id
        }
        function redModi(id){
            location.href='./modificarPregunta.jsp?id='+id
        }
        var va = 3;
        
        function filtrar(valor){
            va = valor;
            $.post('FiltroPreguntasUsu', {
				filtro : valor
			}, function(responseText) {
				$('#cambiar').html(responseText);
			});
        }
        
        filtrar(3);
        
        var socket = new WebSocket("wss://quetzual.herokuapp.com/Responder");
        socket.onmessage = function (event) {
            if(event.data.toString()=== "Respondida"){
                if(va === 3||va === 1){
                    setTimeout(function() {
                        filtrar(va);
                    }, 1000);
                }
            }else if(event.data.toString()=== "Rechazada"){
                if(va === 3 || va === 2){
                    setTimeout(function() {
                        filtrar(va);
                    }, 1000);
                }
            }
            console.log(event.data.toString())
        }
        
    </script>
</body>

</html>