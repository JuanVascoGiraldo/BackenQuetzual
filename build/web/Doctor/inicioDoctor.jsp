<%@page import="java.util.List"%>
<%@page import="Control.GestionarUsuario"%>
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
    List<CCategoria> lista = GestionarUsuario.ProgresoGenerar(usu.getClave());
    CCategoria cat1 = lista.get(0);
    CCategoria cat2 = lista.get(1);
    CCategoria cat3 = lista.get(2);
    CCategoria cat4 = lista.get(3);
    CCategoria cat5 = lista.get(4);
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <% 
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <title>Inicio</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/inicioDoctor.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <link rel="icon" type="image/png" href="./img/icono.png">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img//Logo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article><b>QUETZUAL</b></article>
            <div class="menu">
                <a href="./cuentaDoctor.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Cuenta</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="./preguntasPendientes.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Preguntas</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="./ranking.jsp" style="margin-right: 2%; margin-left: 2%;">
                    <article style="font-size: 20px;">Ranking</article>
                </a>
                &nbsp;
                &nbsp;
                <a href="../CerrarSesion" style="margin-right: 2%; margin-left: 2%;">
                    <img src="./img/salir.png" alt="Salir" class="svg">
                </a>
                &nbsp;
                &nbsp;

            </div>
        </nav>
    </header>


    <div>
        <h1>Bienvenido Doctor</h1>
        <p>Estos son los datos m??s recientes desde la ultima vez</p>
    </div>
    <div class="bar">
        <canvas id="docChart"></canvas>
    </div>
    <script> 
    var ctx = document.getElementById('docChart').getContext('2d');
    var docChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['<%=cat1.getDes_cat()%>', '<%=cat2.getDes_cat()%>', '<%=cat3.getDes_cat()%>', '<%=cat4.getDes_cat()%>', '<%=cat5.getDes_cat()%>'],
            datasets: [{
                label: 'Puntos',
                data: [<%=cat1.getPuntos()%>, <%=cat2.getPuntos()%>, <%=cat3.getPuntos()%>, <%=cat4.getPuntos()%>, <%=cat5.getPuntos()%>],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            aspectRatio: 1,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    </script>
    <script src="./JS/redirigir.js"></script>
</body>

</html>
