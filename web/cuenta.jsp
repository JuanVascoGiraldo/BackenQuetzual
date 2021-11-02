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
        response.sendRedirect("index.jsp");
    }
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");

%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cuenta</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/cuenta.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img/logotipo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article>Cuenta</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./sesionUsuario.jsp">
                <img src="./img/bx-home.svg" alt="Imagen "> Inicio
            </a>
            <a href="./preguntasPendientes.jsp">
                <img src="./img/bx-question-mark.svg" alt="Signo de pregunta" class="svg"> Mis preguntas
            </a>
        </div>
    </header>

    <div class="datos">
        <p>Nombre</p>
        <p>Correo electronico</p>
        <p>Fecha de nacimiento</p>
        <p>Sexo</p>
    </div>
    <div class="title">
        <h1>Aprovechamiento del sistema</h1>
        <hr>
    </div>
    <div class="explicación">
        <p>
            Las siguientes graficas muestran los resultados de acuerdo a las preguntas respondidas y las rechazadas, a su vez tambien se muestra la comparación de las preguntas que has calificado con respecto a la utilidad que te han dado al igual de estar clasificada
            por categoria.
        </p>
    </div>
    <div class="flex">
        <div class="bar">
            <canvas id="myChart"></canvas>
        </div>
        <div class="pie">
            <canvas id="piechart"></canvas>
        </div>
    </div>
    <div class="title">
        <h1>Modificar Cuenta</h1>
        <hr>
    </div>
    <div class="flex">
        <div class="card">
            <form action="ModifcarCuenta" name="modicuenta">
                <input type="text" name="nombre" id="nombre" placeholder="Nombre de Usuario" class="input" value="<%=usu.getNom_usu() %>">
                <input type="email" name="correo" id="correo" placeholder="Correo electronico" class="input" value="<%=usu.getEmail() %>">
                <br>
                <label for="" class="article">Fecha de nacimiento</label><br>
                <input type="date" name="fecha" id="fecha" class="input" value="<%=usu.getFecha_nac() %>">
                <br>
                <label for="" class="article">Sexo</label>
                <br>
                <select name="sexo" id="sexo" class="select">
                <option value="3" <% if(usu.getId_gen() == 3){%>selected <%}%>>Masculino</option>
                <option value="2" <% if(usu.getId_gen() == 2){%>selected <%}%>>Femenino</option>
                <option value="1" <% if(usu.getId_gen() == 1){%>selected <%}%>>Prefiero no decirlo</option>
            </select>
                <button type="button" id="modificar" class="submit" onclick="modC()">Modificar Cuenta</button>
            </form>
        </div>
        <div class="card">
            <form action="ModificarContra" name="ModContra">
                <input type="password" name="pass" id="antpass" placeholder="Contraseña Actual" class="input">
                <input type="password" name="newpass" id="password" placeholder="Nueva Contraseña" class="input">
                <input type="password" name="" id="confpass" placeholder="Confirmar Nueva Contraseña" class="input">
                <button type="button" id="modPassword" class="submit" onclick="modP()">Cambiar contraseña</button>
            </form>
        </div>
    </div>
    <div class="modal" id="modalR">
        <div class="card">
            <article>
                <b>
                    Cuidado, esta acción será permanente, una ver eliminada la cuenta, tus datos y todo el progreso no podrán recuperarse ¿Desea continuar?
                </b>
            </article>
            <button class="cs">Eliminar cuenta</button> <br>
            <button class="submit" onclick="crm()">Deseo permanecer en el sistema</button>
        </div>
    </div>
    </div>
    <button class="cs" data-open="modalR"><b>Eliminar cuenta</b></button>
    <script type="text/javascript" src="./JS/graficas.js"></script>
    <script src="./JS/funcionModal.js"></script>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
</body>

</html>
