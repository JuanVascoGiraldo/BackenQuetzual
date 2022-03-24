<%@page import="Control.GestionarPregunta"%>
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
    List<MPregunta> pre = GestionarPregunta.ConsultarAllPreRes(usu.getClave() );
   
%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Preguntas pendientes</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/preguntasPendientes.css">
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
                <a href="./ranking.jsp">
                    <img src="./img/bx-line-chart.png" alt="Signo de editar" class="svg">
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
        <h1>Preguntas Usuario</h1>
        <hr>
    </div>
    <div class="filtro">
        <select name="filtro" id="filtro" onchange="javascript:location.href = this.value;">
            <option value="1">Preguntas pendientes</option>
            <option value="2">Preguntas respondidas</option>
        </select>
    </div>
    <div id="cambiar">
    <!--preguntas pendientes-->
        <div class="main_container">
            <div class="mini_header2">
                <h2>12-10-2022</h2>
            </div>
            <div class="pregunta">
                <img src="./img/bxs-user.svg" alt="">
                <textarea name="" id="" class="area" placeholder="Escribe aquí tu pregunta" disabled>¿Que metodos anticonceptivos existes?</textarea>
            </div>
            <div class="flex">
                <button class="question" onclick="responder('<%=pre.getId_pre() %>')">Responder pregunta</button>
                <button class="cs" onclick="rechazar('<%=pre.getId_pre() %>')">Rechazar pregunta</button>
            </div>
        </div>
    <!--Preguntas Respondidas-->
        <div class="main_containerR">
            <div class="mini_headerR">
                <h2>18 años</h2>
                <h2><!--<% 
                    if(res.getId_catgen() == 1){
                    %>Enfermedades de transmisión sexual<%
                    }else if(res.getId_catgen() == 2){
                    %>Embarazo<%
                    }else if(res.getId_catgen() == 3){
                    %>Salud sexual femenina<%
                    }else if(res.getId_catgen() == 4){
                    %> Salud sexual masculina<%
                    }else if(res.getId_catgen() == 5){
                    %>Anticonceptivos <%
                    }
                
                    %>-->
                    Enfermedades de transmisión sexual
                </h2>
                <h2>2 Respuestas</h2>
            </div>
            <div class="preguntaR">
                <img src="./img/bxs-user.svg">
                <div class="preguntasR">
                    <h3>¿Que metodos anticonceptivos se usan comunmente?</h3>
                </div>
            </div>
            <div class="respuestaR">
                <a href="./respuestasPregunta.jsp?id=<%=res.getId_pre() %>">Ver respuestas</a>
            </div>
        </div>
            <div class="vacio">
                <p>No hay Preguntas Pendientes Actualmente</p>
                <img src="./img/sinprependoc.svg">
            </div>
        </div>
    <script src="./JS/redirigir.js"></script>
    <script>
        function responder(id){
            location.href='./responderPregunta.jsp?id='+id 
        }
        function rechazar(id){
            location.href='./rechazarPregunta.jsp?id='+id 
        }
    </script>
</body>

</html>
