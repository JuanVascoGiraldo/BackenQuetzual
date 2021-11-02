<%@page import="Control.GestionarUsuario"%>
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
    MUsuario usua = (MUsuario)sesion.getAttribute("usuario");
    int id = 0; 
    try{
        id= Integer.valueOf(request.getParameter("id"));
    }catch(Exception e){
        response.sendRedirect("./adminDoctores.jsp");
    }
    MUsuario usu = GestionarUsuario.consultarDoctor(id, usua.getClave());

%>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/consultarHistorico.css">
</head>

<body>
    <button class="menu" data-open="modalR"><img src="./img/bx-menu (2).svg"></button>
    <h1>Historico</h1>
    <div class="title">
        <h2>Dr. Vasco Giraldo Juan Esteban</h2><br>
        <hr>
    </div>
    <div class="flex">
        <button onclick="enviarAdminDoctores()"><img src="./img/bxs-left-arrow.svg" class="img">Volver</button>
        <h2>Preguntas Respondidas</h2>
    </div>
    <div class="card">
    <form action="../ModificarDoctor" name="ModCuentaDoctor">
        <input type="hidden" name="idd" value="<%=id%>" >
        <input type="text" name="nombred" id="nombred" placeholder="Nombre de Usuario" class="input" value="<%=usu.getNom_usu() %>">
        <input type="text" name="correod" id="correod" placeholder="Correo electronico" class="input" value="<%=usu.getEmail() %>">
        <br>
        <label for="" class="article">Fecha de nacimiento</label><br>
        <input type="date" name="fechad" id="fechad" class="input" value="<%=usu.getFecha_nac() %>">
        <br>
        <label for="" class="article">Sexo</label>
        <br>
        <select name="sexod" id="" class="select">
        <option value="3" <% if(usu.getId_gen() == 3){%>selected <%}%>>Masculino</option>
        <option value="2" <% if(usu.getId_gen() == 2){%>selected <%}%>>Femenino</option>
        <option value="1" <% if(usu.getId_gen() == 1){%>selected <%}%>>Prefiero no decirlo</option>
    </select>
        <button type="button" class="submit" onclick="modificarcuentadr()">Modificar Cuenta</button>
    </form>
</div>
    <div class="filtro">
        <select name="filtro" id="filtro">
            <option selected disabled hidden>Selecciona el filtro de preguntas</option>
            <option value="a">Preguntas Rechazadas</option>
            <option value="a">Preguntas Respondidas</option>
        </select>
    </div>
    <div class="card">
        <div class="main_container">
            <div class="mini_header">
                <h2>Edad</h2>
                <h2>Categoria</h2>
                <h2>4.7
                    <p class="star">★</p>
                </h2>
                <h2>150 Reseñas</h2>
            </div>
            <div class="sub_header">
                <h2>22/09/2021 - Respondido: 23/09/2021</h2>
                <h2>Dr. Juan Manuel Mendoza</h2>
            </div>
            <div class="pregunta">
                <img src="./img/bxs-user.svg" class="img">
                <div class="preguntas">
                    <h3>Tuve relaciones con mi pareja, y deacuerdo a mis sintomas creo que tengo S.I.D.A. pero temo ir al medico. Podría por favor ayudarme a saber si podría padecer S.I.D.A. y cual sería un posible tratamiento por favor? Estos son mis sintomas:
                        1.- Dolor al tragar 2.- Diarrea 3.- Llagas en la ingle</h3>
                </div>
            </div>
            <div class="respuesta">
                <div class="respuestas">
                    <h3>Tus síntomas en general indican que podrías padecer S.I.D.A. Sin embargo, ningún médico puede darte un diagnóstico sin realizar estudio de laboratorio. El tratamiento consiste en antivirales para el VIH. Es necesario que acudas a un
                        médico lo más pronto posible. No debes temer de ir al doctor, es mejor ir a tiempo y no cuando sea demasiado tarde. Puedes pedir a una persona de confiansa que te acompañe para sentirte más tr</h3>
                </div>
                <img src="./img/bx-plus-medical.svg" class="img">
            </div>
        </div>
    </div>
    <div class="card">
        <div class="mini_header2">
            <h2>22/09/2021</h2>
        </div>
        <div class="pregunta2">
            <img src="./img/bxs-user.svg" class="img">
            <div class="preguntas2">
                <h3>Lorem ipsum dolor sit amet consectetur adipisicing elit. Culpa atque quo minus dolorum id cupiditate odit eligendi in qui voluptates?</h3>
            </div>
            <h2>Razón del rechazo</h2>
            <div class="preguntas2">
                <h3>Lorem ipsum dolor sit amet consectetur adipisicing elit. Adipisci porro iure perferendis, nemo in, aliquid laudantium sequi iste blanditiis suscipit fugit velit, non minima ducimus? Nisi asperiores repellat itaque laboriosam.</h3>
            </div>
        </div>
    </div>
    <div class="card">
        <div class="mini_header2">
            <h2>22/09/2021</h2>
        </div>
        <div class="pregunta2">
            <img src="./img/bxs-user.svg" class="img">
            <div class="preguntas2">
                <h3>Lorem ipsum dolor sit amet consectetur adipisicing elit. Culpa atque quo minus dolorum id cupiditate odit eligendi in qui voluptates?</h3>
            </div>
            <h2>Razón del rechazo</h2>
            <div class="preguntas2">
                <h3>Lorem ipsum dolor sit amet consectetur adipisicing elit. Adipisci porro iure perferendis, nemo in, aliquid laudantium sequi iste blanditiis suscipit fugit velit, non minima ducimus? Nisi asperiores repellat itaque laboriosam.</h3>
            </div>
        </div>
    </div>
    <div class="card">
        <div class="mini_header2">
            <h2>22/09/2021</h2>
        </div>
        <div class="pregunta2">
            <img src="./img/bxs-user.svg" class="img">
            <div class="preguntas2">
                <h3>Lorem ipsum dolor sit amet consectetur adipisicing elit. Culpa atque quo minus dolorum id cupiditate odit eligendi in qui voluptates?</h3>
            </div>
            <h2>Razón del rechazo</h2>
            <div class="preguntas2">
                <h3>Lorem ipsum dolor sit amet consectetur adipisicing elit. Adipisci porro iure perferendis, nemo in, aliquid laudantium sequi iste blanditiis suscipit fugit velit, non minima ducimus? Nisi asperiores repellat itaque laboriosam.</h3>
            </div>
        </div>
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
    <script src="./JS/redirigir.js"></script>
    <script src="./JS/funcionModal.js"></script>
    <script src="./JS/validar.js"></script>
    <div class="modal" id="modalR">
        <div class="card">
            <article>
                <h2>La Cuenta ha sido modificada con exito</h2>
            </article>
            <img src="./img/check-square-solid-240.png" alt="">
        </div>
    </div>
</body>
</html>
