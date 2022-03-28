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
        <jsp:forward page="index.jsp">
            <jsp:param name="Error" value="Es obligatorio identificarse" />
        </jsp:forward>
<%
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
    <title>Inicio</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/sesionUsuario.css">
    <link rel="stylesheet" href="./CSS/star-rating-svg.css">
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="./JS/jquery.star-rating-svg.js"></script>
    <link rel="icon" type="image/png" href="./img/icono.png">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img//Logo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article><b>QUETZUAL</b></article>
            <div class="menu">
                <a href="./cuenta.jsp">
                    <img src="./img/bx-user-circle.png" width="40" alt="Signo de pregunta" class="svg">
                </a>
                <a href="./preguntasPendientes.jsp">
                    <img src="./img/bx-question-mark.png" alt="Signo de pregunta" class="svg">
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
        <h1>Bienvenido usuario</h1>
        <hr>
        <p>En este espacio puedes consultar las preguntas que otros usuarios ya han realizado previamente.
        </p>
        <p>¡Tal vez tu duda ya ha sido contestada!</p>
        <p>Puedes explorar este espacio usando el Menu desplegable para buscar preguntas que se relacionan directamente con tu duda.</p>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:filtrar(this.value)">
            <option disabled hidden>Selecciona el tema de tu interes</option>
            <!--Aqui se va a ocupar ajax para los filtros-->
            <option value="0" >Todos</option>
            <option value="1" >Enfermedades de transmisión sexual</option>
            <option value="5" >Anticonceptivos</option>
            <option value="2" >Embarazo</option>
            <option value="3" >Salud sexual femenina</option>
            <option value="4" >Salud sexual masculina</option>
        </select>
    </div>
    
    <div id="cambiar">
        
    </div>
    <script>
        function filtrar(valor){
            $.post('FiltroCat', {
				filtro : valor
			}, function(responseText) {
				$('#cambiar').html(responseText);
			});
        }
        filtrar(0);
    </script>
            
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>

</html>