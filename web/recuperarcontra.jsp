<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar Contraseña</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/estilos.css">
    <link rel="icon" type="image/png" href="./img/icono.png">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body style="background-color: #FFF9ED; background-image: url('./img/gatoError.jpg');background-size: cover;">
    <div class="alinear">
        <div class="grid">
            <div class="form" style="background-color: rgba(252, 252, 252, 0.7);">
                <div id="cambiar">
                    <form action="" name="reccontra" style="background-color: rgba(252, 252, 252, 0);;">
                        <h4>Modificar Contraseña</h4>
                        <input type="password" name="contra" id="contra" class="texto" placeholder="Contraseña">
                        <input type="password" name="confcontra" id="confcontra" class="texto" placeholder=" Confirma la Contraseña">
                        <button type="button" id="IniciarSesion" class="submit button" onclick=" RecuperarContra()" style="border: 1px solid black;">Modificar Contraseña</button>
                    </form>
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
            location.href = 'index.html';
        }
    </script>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>
</html>