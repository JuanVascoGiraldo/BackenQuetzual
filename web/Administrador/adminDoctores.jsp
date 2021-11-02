<%@page import="java.util.List"%>
<%@page import="Modelo.*"%>
<%@page import="Control.*"%>
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
    MUsuario usus = (MUsuario)sesion.getAttribute("usuario");
    List<MUsuario> doctores = GestionarUsuario.BuscarDoctores(usus.getClave());
%>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/adminDoctores.css">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <button class="menu" data-open="modalR"><img src="./img/bx-menu (2).svg"></button>
    <h1>Administrar Doctores</h1>
    <div class="card2">
        <button class="ac" data-open="modal2">Agregar Cuenta</button>
        <%
            for(MUsuario usu:doctores){
        %>
        <div class="alinear">
            <div class="flex">
                <div class="m">
                    <img src="./img/bx-plus-medical.svg">
                </div>
                <div></div>
                <div class="text">
                    <h2><%=usu.getNom_usu() %></h2>
                    <hr>
                    <h4><%=usu.getId_usu() %></h4>
                    <h3><%=usu.getEmail() %></h3>
                    <h3><%=usu.getFecha_nac() %></h3>
                    <h3><%if(usu.getId_gen() == 1){%>Prefiero no Decirlo<%}else if(usu.getId_gen() == 2){%>Femenino<%}else if(usu.getId_gen() == 3){%>Masculino<%} %></h3>
                </div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
            </div>
            <div class="btn">
                <button class="cs" data-open="modal3">Inhabilitar cuenta</button>
                <a href="consultarHistorico.jsp?id=<%=usu.getId_usu() %>"><button class="ch" >Consultar historico</button></a>
            </div>
        </div>
        <% } %>
    </div>
    <div class="modal" id="modalR">
        <aside class="modal-dialog">
            <img src="./img/logotipo.png">
            <button onclick="enviarSesionAdmin()">Inicio</button>
            <button onclick="enviarCuentaAdmin()">Cuenta</button>
            <button onclick="enviarRankingAdmin()">Ranking</button>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </aside>
    </div>
    <div class="modal2" id="modal2">
        <div class="card">
            <form action="../RegistrarDoctor" name="registrarDoc">
                <input type="text" name="nombre" id="name" placeholder="Nombre de Usuario" class="input">
                <input type="email" name="email" id="email" placeholder="Correo electronico" class="input">
                <br>
                <label for="" class="article">Fecha de nacimiento</label><br>
                <input type="date" name="fecha" id="date" class="input">
                <br>
                <label for="" class="article">Sexo</label>
                <br>
                <select name="sexo" id="" class="select">
                <option value="3">Masculino</option>
                <option value="2">Femenino</option>
                <option value="1">Prefiero no decirlo</option>
            </select>
                <input type="password" name="pass" id="password1" placeholder="Contraseña" class="input">
                <input type="password" name="passwordConfirm1" id="passwordConfirm1" placeholder="Confirmar Contraseña" class="input">
                <button type="button" class="submit" onclick="registrardr()">Registrar Doctor</button>
            </form>
        </div>
    </div>
    <div class="modal2" id="modal3">
        <div class="card">
            <h4>Cuidado, esta acción podría afectar el flujo del sistema</h4>
            <button class="cs">Inhabilitar cuenta</button>
            <button class="submit">No inhabilitar cuenta</button>
        </div>
    </div>
    <script src="./JS/redirigir.js"></script>
    <script src="./JS/funcionModal2.js"></script>
    <script src="./JS/validar.js"></script>
    
</body>

</html>
