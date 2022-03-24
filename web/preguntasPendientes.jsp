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
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option selected disabled hidden>Selecciona el filtro de preguntas</option>
            <option value="1">Preguntas Respondidas</option>
            <option value="2">Preguntas rechazadas</option>
            <option value="3" selected>Preguntas pendientes</option>
        </select>
    </div>
    <div id="cambiar">
    <!--Preguntas pendientes-->
        <div class="title">
            <h1>Preguntas Pendientes</h1>
            <hr>
            <p>En este espacio puedes consultar tus preguntas que están en espera de recibir respuesta</p>
        </div>
        <div class="main_container">
            <div class="mini_header">
                <h2>Pendiente</h2>
            </div>
            <div class="sub_header">
                <h2>12-02-2022 - Respondido: Por definir</h2>
                <h2>Dr. Por Definir</h2>
            </div>
                <div class="pregunta">
                    <div class="preguntas">
                        <p class="text">¿que son los metodos anticonceptivos?</p>
                    </div>
                </div>
                <div class="pregunta">
                    <button class="cs" onclick="redeliminar('')">Eliminar pregunta</button>
                    <button class="question" data-open="modalR" onclick="redModi('')" >Modificar Pregunta</button>
                </div>
        </div>
        <div class="vacio">
            <p>No Tienes Preguntas Pendientes Actualmente</p>
            <img src="./img/sinprepenusu.svg">
        </div>
    <!--Preguntas Rechazadas-->
        <div class="title">
            <h1>Preguntas rechazadas</h1>
            <hr>
            <p>En este espacio puedes consultar las preguntas que han sido rechazadas por los doctores.</p>
        </div>
        <div class="cardR">
            <div class="mini_headerR">
                <h2 class="h2">12-02-2022</h2>
            </div>
            <div class="preguntaR">
                <img src="./img/bxs-user.svg" alt="">
                <div class="preguntasR">
                    <h3>¿Que metodos anticonceptivos existen?</h3>
                </div>
                <h1 class="h1R">Razón del rechazo</h1>
                <div class="preguntasR">
                    <h3>Pregunta ya respondida</h3>
                </div>
            </div>
        </div>
        <div class="vacio">
            <p>No Tienes Preguntas Rechazadas Actualmente</p>
            <img src="./img/sinprerechusu.svg">
        </div>
    <!--Preguntas Respondidas-->
        <div class="title">
            <h1>Preguntas Respondidas</h1>
            <hr>
        </div>
        <div class="main_containerRe">
            <div class="mini_headerRe">
                <h2 class="h2">18 Años</h2>
                <h2 class="h2">Embarazo</h2>
                <h2 class="h2">2 Respuestas</h2>
            </div>
            <div class="preguntaRe">
                <img src="./img/bxs-user.svg" alt="">
                <div class="preguntasRe">
                    <h3 class="h3">¿Que metodos anticonceptivos existen?</h3>
                </div>
            </div>
            <div class="respuestaRe">
                <a href="./respuestasPregunta.jsp?id=<%=pre.getId_pre() %>&&re=1" class="aRe">Ver respuestas</a>
            </div>

        </div>
        <div class="vacio">
            <p>No Tienes Preguntas Respondidas Actualmente</p>
            <img src="./img/sinpreresusu.svg">
        </div>
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
    </script>
</body>

</html>