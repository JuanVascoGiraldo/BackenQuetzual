<%@page import="java.util.List"%>
<%@page import="Control.GestionarUsuario"%>
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
    <title>Administrador</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/sesionAdmin.css">
    <link rel="icon" type="image/png" href="./img/icono.png">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>

<body>
    <aside>
        <img src="./img/LogoBlancoLetrasSinFondo.png">
        <button onclick="enviarAdminDoctores()">Administrar doctores</button>
        <button onclick="enviarCuentaAdmin()">Cuenta</button>
        <button onclick="enviarRankingAdmin()">Ranking</button>
        <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
    </aside>
    <h1>Bienvenido Administrador</h1>
    <div>Estos son los datos más recientes desde la última vez</div>
    <div class="bar">
        <canvas id="admChart"></canvas>
    </div>
    <script src="./JS/redirigir.js"></script>
    <script>
        var ctx = document.getElementById('admChart').getContext('2d');
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
</body>

</html>