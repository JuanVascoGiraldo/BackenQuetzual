<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Control.GestionarUsuario"%>
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
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    
    List<CCategoria> lista = GestionarUsuario.ProgresoUSuario(usu.getId_usu(), usu.getClave());
    CCategoria cat1 = lista.get(0);
    CCategoria cat2 = lista.get(1);
    CCategoria cat3 = lista.get(2);
    CCategoria cat4 = lista.get(3);
    CCategoria cat5 = lista.get(4);
    
    

%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cuenta</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/cuenta.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img/logotipo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article>Cuenta</article>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </nav>
        <div class="menu">
            <a href="./sesionUsuario.jsp">
                <img src="./img/bx-home.svg" alt="Imagen "> Inicio
            </a>
            <a href="./preguntasPendientes.jsp">
                <img src="./img/bx-question-mark.svg" alt="Signo de pregunta" class="svg"> Mis preguntas
            </a>
        </div>
    </header>

    <div class="datos">
        <p>Nombre</p>
        <p>Correo electronico</p>
        <p>Fecha de nacimiento</p>
        <p>Sexo</p>
    </div>
    <div class="title">
        <h1>Aprovechamiento del sistema</h1>
        <hr>
    </div>
    <div class="explicación">
        <p>
            Las siguientes graficas muestran los resultados de acuerdo a las preguntas respondidas y las rechazadas, a su vez tambien se muestra la comparación de las preguntas que has calificado con respecto a la utilidad que te han dado al igual de estar clasificada
            por categoria.
        </p>
    </div>
    <div class="flex">
        <div class="bar">
            <canvas id="myChart"></canvas>
        </div>
        <div class="pie">
            <canvas id="piechart"></canvas>
        </div>
    </div>
    <div class="title">
        <h1>Modificar Cuenta</h1>
        <hr>
    </div>
    <div class="flex">
        <div class="card">
            <form action="ModifcarCuenta" name="modicuenta">
                <input type="text" name="nombre" id="nombre" placeholder="Nombre de Usuario" class="input" value="<%=usu.getNom_usu() %>">
                <input type="email" name="correo" id="correo" placeholder="Correo electronico" class="input" value="<%=usu.getEmail() %>">
                <br>
                <label for="" class="article">Fecha de nacimiento</label><br>
                <input type="date" name="fecha" id="fecha" class="input" value="<%=usu.getFecha_nac() %>">
                <br>
                <label for="" class="article">Sexo</label>
                <br>
                <select name="sexo" id="sexo" class="select">
                <option value="3" <% if(usu.getId_gen() == 3){%>selected <%}%>>Masculino</option>
                <option value="2" <% if(usu.getId_gen() == 2){%>selected <%}%>>Femenino</option>
                <option value="1" <% if(usu.getId_gen() == 1){%>selected <%}%>>Prefiero no decirlo</option>
            </select>
                <button type="button" id="modificar" class="submit" onclick="modC()">Modificar Cuenta</button>
            </form>
        </div>
        <div class="card">
            <form action="ModificarContra" name="ModContra">
                <input type="password" name="pass" id="antpass" placeholder="Contraseña Actual" class="input">
                <input type="password" name="newpass" id="password" placeholder="Nueva Contraseña" class="input">
                <input type="password" name="" id="confpass" placeholder="Confirmar Nueva Contraseña" class="input">
                <button type="button" id="modPassword" class="submit" onclick="modP()">Cambiar contraseña</button>
            </form>
        </div>
    </div>
    <div class="modal" id="modalR">
        <div class="card">
            <article>
                <b>
                    Cuidado, esta acción será permanente, una ver eliminada la cuenta, tus datos y todo el progreso no podrán recuperarse ¿Desea continuar?
                </b>
            </article>
            <button class="cs" onclick="eliminar()">Eliminar cuenta</button> <br>
            <button class="submit" onclick="crm()">Deseo permanecer en el sistema</button>
        </div>
    </div>
    </div>
    <button class="cs" data-open="modalR"><b>Eliminar cuenta</b></button>
    <script>
        function eliminar(){
            location.href = './EliminarCuenta';
        }
    </script>
    <script src="./JS/funcionModal.js"></script>
    <script src="./JS/validar.js"></script>
    <script src="./JS/sweetAlert.js"></script>
    <script>
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
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
var ctx = document.getElementById('piechart').getContext('2d');
<% 
    List<Integer> listas = GestionarUsuario.ProgresoPreguntas(usu.getId_usu(), usu.getClave());
    int res = 0 ;
    int rech = 0;
    int i = 0;
    for(int e: listas){
        if(i==0)res = e;
        if(i==1)rech = e;
        i++;
    }
%>
var piechart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['Aceptadas', 'Rechazadas'],
        datasets: [{
            label: 'Preguntas',
            data: [<%=res%>,<%=rech %>,],
            backgroundColor: [
                'rgba(75, 192, 192, 0.2)',
                'rgba(255, 99, 132, 0.2)'
            ],
            borderColor: [
                'rgba(75, 192, 192, 1)',
                'rgba(255, 99, 132, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: true,
        aspectRatio: 1,
    }
});
    </script>
</body>

</html>
