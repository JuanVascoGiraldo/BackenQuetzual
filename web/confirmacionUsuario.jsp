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

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmación</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/confirmacionUsuario.css">
</head>

<body>
    <img src="./img/gatitoConfirmacion.jpg">
    <div class="modal">
        <p>
            Tu pregunta se ha realizado con exito
        </p><br>
        <a href="./preguntasPendientes.jsp"><button>Aceptar</button></a>
    </div>
</body>

</html>
