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
        function redeliminar(id){
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
        console.log(va===3)
        
        var socket = new WebSocket("wss://quetzual.herokuapp.com/Responder");
        socket.onmessage = function (event) {
                if(va === 3){
                    setTimeout(function() {
                        filtrar(3);
                    }, 1000);
                }
        }
        
    </script>
</body>

</html>