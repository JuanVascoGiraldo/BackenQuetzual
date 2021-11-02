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
</head>

<body>
    <button class="menu" data-open="modalR"><img src="./img/bx-menu (2).svg"></button>
    <h1>Mejores desempeños</h1>
    <div class="filtro">
        <select name="filtro" id="filtro">
            <option selected disabled hidden>Filtrar por fecha</option>
            <option value="a">General</option>
            <option value="a">Mensual</option>
        </select>
    </div>
    <div class="main_container">
        <div class="grid">
            <div class="encabezado">
                <div class="doctores">Doctores</div>
                <div class="puntos">Puntos</div>
            </div>
            <div class="primero">
                <div class="doctores">1. Garcia Garcia Aram Jesua</div>
                <div class="puntos">452 🏆</div>
            </div>
            <div class="segundo">
                <div class="doctores">2. Vasco Giraldo Juan Esteban</div>
                <div class="puntos">426 🏆</div>
            </div>
            <div class="tercero">
                <div class="doctores">3. Elizalde Hernández Alan</div>
                <div class="puntos">350 🏆</div>
            </div>
            <div class="participante">
                <div class="doctores">4. López Castillo Azurim</div>
                <div class="puntos">330 🏆</div>
            </div>
            <div class="participante">
                <div class="doctores">5. López Castillo Azurim</div>
                <div class="puntos">330 🏆</div>
            </div>
            <div class="participante">
                <div class="doctores">6. López Castillo Azurim</div>
                <div class="puntos">330 🏆</div>
            </div>
            <div class="participante">
                <div class="doctores">7. López Castillo Azurim</div>
                <div class="puntos">330 🏆</div>
            </div>
            <div class="participante">
                <div class="doctores">8. López Castillo Azurim</div>
                <div class="puntos">330 🏆</div>
            </div>
            <div class="participante">
                <div class="doctores">9. López Castillo Azurim</div>
                <div class="puntos">330 🏆</div>
            </div>
            <div class="participante">
                <div class="doctores">10. López Castillo Azurim</div>
                <div class="puntos">330 🏆</div>
            </div>
            <div class="participante">
                <div class="doctores">11. López Castillo Azurim</div>
                <div class="puntos">330 🏆</div>
            </div>
            <div class="participante">
                <div class="doctores">12. López Castillo Azurim</div>
                <div class="puntos">330 🏆</div>
            </div>
            <div class="participante">
                <div class="doctores">13. López Castillo Azurim</div>
                <div class="puntos">330 🏆</div>
            </div>
        </div>
    </div>
    <div class="modal" id="modalR">
        <aside class="modal-dialog">
            <img src="./img/logotipo.png">
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
