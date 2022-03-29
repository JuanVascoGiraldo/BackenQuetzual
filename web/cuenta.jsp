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
        %> 
        <jsp:forward page="index.jsp">
            <jsp:param name="Error" value="Es obligatorio identificarse" />
        </jsp:forward>
<%
    }
    MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
    
    List<CCategoria> lista = GestionarUsuario.ProgresoUSuario(usu.getId_usu(), usu.getClave(), usu.getToken());
    CCategoria cat1 = lista.get(0);
    CCategoria cat2 = lista.get(1);
    CCategoria cat3 = lista.get(2);
    CCategoria cat4 = lista.get(3);
    CCategoria cat5 = lista.get(4);

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
    <% 
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <title>Cuenta</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/cuenta.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="icon" type="image/png" href="./img/icono.png">
</head>

<body>
    <header class="header">
        <nav class="navegacion">
            <img src="./img//Logo.png" alt="Logotipo oficial de Quetzual" class="logo">
            <article><b>QUETZUAL</b></article>
            <div class="menu">
                <a href="./sesionUsuario.jsp">
                    <img src="./img/bx-home.png" alt="Imagen ">
                </a>
                <a href="./preguntasPendientes.jsp">
                    <img src="./img/bx-question-mark.png" alt="Signo de pregunta" class="svg">
                </a>
                <a href="./hacerPregunta.jsp">
                    <img src="./img/bx-edit-alt.png" alt="Signo de editar" class="svg">
                </a>
                <a href="CerrarSesion">
                    <img src="./img/salir.png" alt="Signo de pregunta" class="svg">
                </a>
                &nbsp;
                &nbsp;
                &nbsp;
                &nbsp;

            </div>
        </nav>
    </header>
    <h1 style="text-align:center">Cuenta</h1>

    <div class="filcuenta">
        <div class="fil" id="fil" onclick="estadistica()"><h3>Estadistica</h3></div>
        <div class="fil2" id="fil2" onclick="cuenta()"><h3>Cuenta</h3></div>
    </div>
    <br>
    <br>
    <div class="cuen" id="cuen">
        <div class="datos">
            <p>Nombre: <%=usu.getNom_usu() %> </p>
            <p>Correo electronico:<%=usu.getEmail() %> </p>
            <p>Fecha de nacimiento:<%=usu.getFecha_nac() %> </p>
            <p>Sexo:<%if(usu.getId_gen() == 1){%>Prefiero no Decirlo <% }else if(usu.getId_gen() ==2 ){%>Femenino <% }else if(usu.getId_gen() ==3){%>Masculino<%} %> </p>
        </div>
        <div class="title">
            <h1>Modificar Cuenta</h1>
            <hr>
        </div>
        <div class="flex">
            <div class="card">
                <form action="ModifcarCuenta" name="modicuenta">
                    <input type="text" name="nombre" id="nombre" placeholder="Nombre de Usuario" class="input" value="<%=usu.getNom_usu() %>">
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
                <hr width="90%">
                <form action="" name="modemail">
                    <input type="email" name="correo" id="correo" placeholder="Correo electronico" class="input" value="<%=usu.getEmail() %>">
                    <button type="button" id="modificar" class="submit" onclick="ModCorreo()">Modificar Correo</button>
                    <div id="cambiar">

                    </div>
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
    </div>
    <div class="esta" id="esta">
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
    </div>
    
    
    
    <div class="modal" id="modalR">
        <div class="card">
            <article style="color:black">
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
            List<Integer> listas = GestionarUsuario.ProgresoPreguntas(usu.getId_usu(), usu.getClave(), usu.getToken());
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

<script>
    function estadistica(){
        document.getElementById("esta").style.display = "inline";
        document.getElementById("cuen").style.display = "none";
        document.getElementById("fil").style.borderBottom = "2px solid #0066FF";
        document.getElementById("fil2").style.borderBottom = "none";
        document.getElementById("fil").style.hover = "border-bottom: 2px solid #ff00bfd7"

        document.getElementById("fil").addEventListener("mouseover", function() {
            document.getElementById("fil").style.borderBottom  = "2px solid #ff00bfd7";
        });
            
        document.getElementById("fil2").addEventListener("mouseout", function() {
            document.getElementById("fil2").style.borderBottom = "none";
        });

        document.getElementById("fil2").addEventListener("mouseover", function() {
            document.getElementById("fil2").style.borderBottom  = "2px solid #ff00bfd7";
        });
            
        document.getElementById("fil").addEventListener("mouseout", function() {
            document.getElementById("fil").style.borderBottom = "2px solid #0066FF";
        });
    }

    function cuenta(){
        document.getElementById("esta").style.display = "none";
        document.getElementById("cuen").style.display = "inline";
        document.getElementById("fil").style.borderBottom = "none";
        document.getElementById("fil2").style.borderBottom = "2px solid #0066FF";

        document.getElementById("fil").addEventListener("mouseover", function() {
            document.getElementById("fil").style.borderBottom  = "2px solid #ff00bfd7";
        });
            
        document.getElementById("fil").addEventListener("mouseout", function() {
            document.getElementById("fil").style.borderBottom = "none";
        });

        document.getElementById("fil2").addEventListener("mouseover", function() {
            document.getElementById("fil2").style.borderBottom  = "2px solid #ff00bfd7";
        });
            
        document.getElementById("fil2").addEventListener("mouseout", function() {
            document.getElementById("fil2").style.borderBottom = "2px solid #0066FF";
        });

    }
</script>

</body>

</html>