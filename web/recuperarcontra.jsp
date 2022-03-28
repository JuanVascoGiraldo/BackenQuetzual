<%@page import="Modelo.MUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java"%>
<% 
    HttpSession sesion = request.getSession(true);
    if(sesion.getAttribute("usuario") != null){
        MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
        if(usu.getId_rol() == 1){
            response.sendRedirect("sesionUsuario.jsp");
        }else if( usu.getId_rol()== 2){
            response.sendRedirect("./Doctor/inicioDoctor.jsp");
        }else if (usu.getId_rol() == 3){
            response.sendRedirect("./Administrador/sesionAdmin.jsp");
        }
    }
    String token = "";
    if(request.getParameter("token")== null){
        response.sendRedirect("index.html");
    }else{
        token = request.getParameter("token");
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
    <title>Recuperar Contraseña</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/estilos.css">
    <link rel="icon" type="image/png" href="./img/icono.png">
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body style="background-color: #FFF9ED; background-image: url('./img/gatoError.jpg');background-size: cover;">
    <div class="alinear">
        <div class="grid">
            <div class="form" style="background-color: rgba(252, 252, 252, 0.7);">
                <div id="cambiar">
                    
                </div>
                <hr width="90%" style="border:1px solid black;">
                <button type="button" class="submit button" onclick="irInicio()" style="border: 1px solid black;">Inicio</button>
           
            </div>
        </div>
    <footer class="footer ">
        Tecnologia administrativa creativa y operadora de software
    </footer>
    <script>
        function irInicio(){
            location.href = 'index.jsp';
        }
    </script>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
    <script>
        validar();
        function validar(){
            var token = '<%=token%>'
            $.post('ValidarToken', {
                token: token
            }, function(responseText) {
                    $('#cambiar').html(responseText);
            });
            
        }
    </script>
</body>
</html>