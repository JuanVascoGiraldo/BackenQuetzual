

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
        %> 
        <jsp:forward page="paginaError2.html">
        <jsp:param name="Error" value="Es obligatorio identificarse" />
         </jsp:forward>
<%
    }
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    int correo = 0;
    try{
        correo = Integer.valueOf(request.getParameter("correo"));
    }catch(Exception e){
        correo = 0;
    }
    
    int contra = 0;
    try{
        contra = Integer.valueOf(request.getParameter("contra"));
    }catch(Exception e){
        contra = 0;
    }
%>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/cuentaAdmin.css">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="icon" type="image/png" href="./img/icono.png">
</head>

<body>
    <aside>
        <img src="./img/logotipo.png">
        <button onclick="enviarSesionAdmin()">Inicio</button>
        <button onclick="enviarAdminDoctores()">Administrar doctores</button>
        <button onclick="enviarRankingAdmin()">Ranking</button>
        <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
    </aside>
    <h1>Modificar Cuenta</h1>
    <div class="flex">
        <div class="card">
            <form action="../ModifcarCuenta" name="ModCuentaAdmin">
                <input type="text" name="nombre" id="nombreadmin" placeholder="Nombre de Usuario" class="input" value="<%=usu.getNom_usu() %>">
                <input type="text" name="correo" id="correoadmin" placeholder="Correo electronico" class="input" value="<%=usu.getEmail() %>">
                <br>
                <label for="" class="article">Fecha de nacimiento</label><br>
                <input type="date" name="fecha" id="fechaAdmin" class="input" value="<%=usu.getFecha_nac() %>">
                <br>
                <label for="" class="article">Sexo</label>
                <br>
                <select name="sexo" id="" class="select">
                <option value="3" <% if(usu.getId_gen() == 3){%>selected <%}%>>Masculino</option>
                <option value="2" <% if(usu.getId_gen() == 2){%>selected <%}%>>Femenino</option>
                <option value="1" <% if(usu.getId_gen() == 1){%>selected <%}%>>Prefiero no decirlo</option>
            </select>
                <button type="button" class="submit" onclick="modificarcuentaAdmin()">Modificar Cuenta</button>
            </form>
        </div>
        <div class="card">
            <form action="../ModificarContra" name="ModiContraAdmin">
                <input type="password" name="pass" id="passwordact" placeholder="Contraseña Actual" class="input">
                <input type="password" name="newpass" id="newpassword" placeholder="Nueva Contraseña" class="input">
                <input type="password" name="newpasswordconfirm" id="newpasswordconfirm" placeholder="Confirmar Nueva Contraseña" class="input">
                <button type="button" class="submit" onclick="modificarContra()">Cambiar contraseña</button>
            </form>
        </div>
    </div>
    <div class="modal" id="modalR">
        <div class="card">
            <article>
                <h2>La Cuenta ha sido modificada con exito</h2>
            </article>
            <img src="./img/check-square-solid-240.png" alt="">
        </div>
    </div>
    <script src="./JS/redirigir.js"></script>
    <script src="./JS/funcionModal.js"></script>
    <script src="./JS/validar.js"></script>
    
     <% 
        if(contra == 1){
            %> 
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'No se Modificado la cuenta',
                    text: 'No coincide la contraseña de la cuenta '
                });
            </script>
    
    
    <%
        }
    %>
    
    <% 
        if(correo == 1){
            %> 
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Correo ya registrado',
                    text: 'El correo ya ha sido Registrado Intente de nuevo'
                });
            </script>
    
    
    <%
        }
    %>
</body>

</html>
