<%@page import="Modelo.*"%>
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

%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/estilos.css">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <div class="alinear">
        <div class="grid">
            <div class="main-content">
                <div class="img">
                    <img src="./img/logotipo.png" alt="Logotipo oficial de quetzual">
                </div>
                <article class="main-text">
                    Quetzual es una pagina dirigida para los estudiantes del CECyT #9 con el fin de brindar una mejor guía a los estudiantes en su educación sobre salud sexual mediante la resolución de dudas sobre el tema.
                </article>
            </div>
            <div class="form">
                <form action="IniciarSesion" name="iniciar">
                    <input type="text" name="email" id="IScorreo" class="texto" placeholder="Correo">
                    <input type="password" name="contra" id="IScontra" class="texto" placeholder="Contraseña">
                    <button type="button" id="IniciarSesion" class="submit button" onclick="validarIS()">Iniciar sesión</button>
                </form>
                <hr width="90%">
                <button class="Registro" id="registrar" data-open="modalR">
                    <a href="#">Crear cuenta</a>
                </button>
            </div>
        </div>
        <div class="modal" id="modalR">
            <div class="card">
                <form action="RegistrarUsuario" name="registrar">
                    <input type="text" name="nombre" id="nombre" placeholder="Nombre de Usuario" class="input">
                    <input type="text" name="correo" id="correo" placeholder="Correo electronico" class="input">
                    <br>
                    <label for="" class="article">Fecha de nacimiento</label><br>
                    <input type="date" name="fecha" id="fecha" class="input">
                    <br>
                    <label for="" class="article">Sexo</label>
                    <br>
                    <select name="sexo" id="sexo" class="select">
                        <option value="3">Masculino</option>
                        <option value="2">Femenino</option>
                        <option value="1">Prefiero no decirlo</option>
                    </select>
                    <input type="password" name="contra" id="password" placeholder="Contraseña" class="input">
                    <input type="password" name="confcontra" id="confpass" placeholder="Confirmar Contraseña" class="input">
                    <article class="article">Al hacer clic en “Registrarte”, aceptas nuestro <a href="./politicas.html" class="a">Aviso de privacidad</a></article>
                    <button type="button" class="submit" onclick="registrarr()" id="enviar">Registrarse </button>
                </form>
            </div>
        </div>
    </div>
    <footer class="footer ">
        Tecnologia administrativa creativa y operadora de software
    </footer>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>
</html>
