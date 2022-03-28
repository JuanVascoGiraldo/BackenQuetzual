<%@page import="java.util.List"%>
<%@page import="Control.GestionarPregunta"%>
<%@page import="Control.GestionarPregunta"%>
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
    MUsuario usua = (MUsuario)sesion.getAttribute("usuario");
    int id = 0; 
    try{
        id= Integer.valueOf(request.getParameter("id"));
    }catch(Exception e){
        response.sendRedirect("./adminDoctores.jsp");
    }
    MUsuario usu = GestionarUsuario.consultarDoctor(id, usua.getClave(), usua.getToken());
    String nombre = usu.getNom_usu();
    
    if(nombre.equals("no encontrado")){
        response.sendRedirect("./adminDoctores.jsp");
    }
    List<MPublicacion> publi= GestionarPregunta.ConsultatHistoricoDoc(id, usua.getClave(), usua.getToken());
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
    <title>Consultar Historico</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/consultarHistorico.css">
    <link rel="icon" type="image/png" href="./img/icono.png">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
</head>

<body>
    <button class="menu" data-open="modalR"><img src="./img/bx-menu (2).svg"></button>
    <h1>Historico</h1>
    <div class="title">
        <h2>Dr. <%=usu.getNom_usu()%></h2><br>
        <hr>
    </div>
    <div class="flex">
        <button onclick="enviarAdminDoctores()"><img src="./img/bxs-left-arrow.svg" class="img">Volver</button>
    </div>
    <div class="filcuenta">
        <div class="fil1" id="fil" onclick="estadistica()"><h3>Estadistica</h3></div>
        <div class="fil2" id="fil2" onclick="preguntas()"><h3>Preguntas</h3></div>
    </div>
    
    <div class="preg" id="preg">
        <h3>Preguntas</h3>
        <hr class="linea">
        <div class="filtro">
            <select name="filtro" id="filtro" onchange="javascript:filtrar(this.value)">
                <option selected disabled hidden>Selecciona el filtro de preguntas</option>
                <option value="0"  >Todas Las Preguntas</option>
                <option value="1"  >Preguntas Rechazadas</option>
                <option value="2"  >Preguntas Respondidas</option>
            </select>
        </div>
        <div id="cambiar">
            <% 
                int totalp= 0;
                double totalcali = 0;
                int pri=0,dos=0,tre=0,cua=0,cin=0;
                int totald=0;
                
                for(MPublicacion pu: publi){
                    MPregunta pre = pu.getPregunta();
                    MRespuesta res = pu.getRespuesta();
                    if(pre.getId_estado() == 2){
                        totalp++;
                        totalcali += res.getCali_pro();
                        totalp = GestionarUsuario.Calculardia(pre.getFecha_pre(), res.getFecha_res());
            
            %>
            <div class="card">
                <div class="main_container">
                    <div class="mini_header">
                        <h2><%=pre.getEdad_usu() %> años</h2>
                        <h2>
                            <%
                            if(res.getId_cat() == 1){
                                pri++;
                                %>Enfermedades de transmisión sexual<%
                                }else if(res.getId_cat() == 2){
                                tre++;
                                %>Embarazo<%
                                }else if(res.getId_cat() == 3){
                                cua++;
                                %>Salud sexual femenina<%
                                }else if(res.getId_cat() == 4){
                                cin++;
                                %> Salud sexual masculina<%
                                }else if(res.getId_cat() == 5){
                                dos++;
                                %>Anticonceptivos <%
                                }
                            %>
                        </h2>
                        <h2><%=res.getCali_pro() %>
                            <p class="star">★</p>
                        </h2>
                    </div>
                    <div class="sub_header">
                        <h2><%=pre.getFecha_pre() %> - Respondido: <%=res.getFecha_res() %></h2>
                        <h2>Dr. <%=usu.getNom_usu()%></h2>
                    </div>
                    <div class="pregunta">
                        <img src="./img/bxs-user.svg" class="img">
                        <div class="preguntas">
                            <h3><%=pre.getDes_pre()%></h3>
                        </div>
                    </div>
                    <div class="respuesta">
                        <div class="respuestas">
                            <h3><%=res.getDes_res() %></h3>
                        </div>
                        <img src="./img/bx-plus-medical.svg" class="img">
                    </div>
                </div>
            </div>
            <% 
                }else if(pre.getId_estado() == 3){
            %>

            <div class="card">
                <div class="mini_header2">
                    <h2><%=res.getFecha_res() %></h2>
                </div>
                <div class="pregunta2">
                    <div class="preguntas2">
                        <h3><%=pre.getDes_pre()%></h3>
                    </div>
                    <h1 class="h1">Razón del rechazo</h1>
                    <div class="preguntas2">
                        <h3><%=res.getDes_res() %></h3>
                    </div>
                </div>
            </div>
            <% 
                    }
                }
                if(publi.isEmpty()){
            %>
                <div class="vacio">
                    <p>No hay Preguntas en el Historico</p>
                    <img src="./img/sinhis.svg">
                </div>
            <% 
                }
            %>
        </div>
    </div>
    
    <div class="esta" id="esta">
        <h3>Datos</h3>
        <hr class="linea">
        <div class="alinearD">
            <div class="flexD">
                <div class="mD">
                    <img src="./img/bx-plus-medical.svg">
                </div>
                <div></div>
                <div class="text">
                    <h2>Dr. <%=usu.getNom_usu()%></h2>
                    <hr>
                    <%
                        double totalca= 0;
                        double totalpr = 0;
                        if(totalp!=0){
                            totalca = totalcali/totalp;
                            totalpr = totald/totalp;
                        } 
                        String valor = "";
                        if(totalpr <1){
                            valor = "Menos de un dia";
                        }else{
                            valor = totalpr +" Dias";
                        }
                        
                        List<MUsuario> us = GestionarUsuario.puntdoc(id);

                        %>
                    <h3>Tiempo Promedio de respuesta:<%=valor%> </h3>
                    <h3>Calificación Promedio de respuestas:<%=totalca %></h3>
                </div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
            </div>
        </div>
        <br>
        <br>
        <h3>Estadisticas</h3>
        <hr class="linea">
        <br>
        <br>
        <div class="flex">
            <div class="bar">
                Puntos en los ultimos 3 meses
                <canvas id="myChart"></canvas>
            </div>
            
            <div class="pie">
                Cantidad de Preguntas Contestadas por Categoria
                <canvas id="piechart"></canvas>
            </div>
            
        </div>
    </div>

    <div class="modal" id="modalR">
        <aside class="modal-dialog">
            <img src="./img/LogoBlancoLetrasSinFondo.png">
            <button onclick="enviarSesionAdmin()">Inicio</button>
            <button onclick="enviarCuentaAdmin()">Cuenta</button>
            <button onclick="enviarRankingAdmin()">Ranking</button>
            <button class="cs" onclick="cerrarSesion()">Cerrar sesión</button>
        </aside>
    </div>
    <script src="./JS/redirigir.js"></script>
    <script src="./JS/funcionModal.js"></script>
    <script src="./JS/validar.js"></script>
    <script>
         var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ["<%=us.get(2).getMes() %>","<%=us.get(1).getMes() %>" ,"<%=us.get(0).getMes() %>"],
            datasets: [{
                label: 'Puntos',
                data: [<%=us.get(2).getPuntos() %>, <%=us.get(1).getPuntos() %>, <%=us.get(0).getPuntos() %>],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)'
                ],
                borderColor: [
                    'rgb(255, 99, 132)'
                ],
                borderWidth: 4
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
    var piechart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ["ETS","Anticonceptivos" ,"Embarazo" ,"Salud sexual femenina" ,"Salud sexual masculina" ],
            datasets: [{
                label: 'Cantidad de Preguntas Contestadas por Categoria',
                data: [<%=pri%>, <%=dos%>, <%=tre%>, <%=cua%>, <%=cin%>],
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
        }
    });
        </script>

<script>
    function estadistica(){
        document.getElementById("esta").style.display = "inline";
        document.getElementById("preg").style.display = "none";
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
    
    function filtrar(valor){
        var id = <%=id %>
        $.post('../FilHistAdm', {
                filtro : valor,
                id: id
        }, function(responseText) {
                $('#cambiar').html(responseText);
        });
    }

    function preguntas(){
        document.getElementById("esta").style.display = "none";
        document.getElementById("preg").style.display = "inline";
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