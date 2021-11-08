<%@page import="java.util.List"%>
<%@page import="Modelo.*"%>
<%@page import="Control.*"%>
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
    MUsuario usus = (MUsuario)sesion.getAttribute("usuario");
    List<MUsuario> doctores = GestionarUsuario.BuscarDoctores(usus.getClave());
    
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
    <link rel="stylesheet" href="./CSS/adminDoctores.css">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <button class="menu" data-open="modalR"><img src="./img/bx-menu (2).svg"></button>
    <h1>Administrar Doctores</h1>
    <div class="card2">
        <button class="ac" data-open="modal2">Agregar Cuenta</button>
        <%
            for(MUsuario usu:doctores){
        %>
        <div class="alinear">
            <div class="flex">
                <div class="m">
                    <img src="./img/bx-plus-medical.svg">
                </div>
                <div></div>
                <div class="text">
                    <h2><%=usu.getNom_usu() %></h2>
                    <hr>
                    <h4><%=usu.getId_usu() %></h4>
                    <h3><%=usu.getEmail() %></h3>
                    <h3><%=usu.getFecha_nac() %></h3>
                    <h3><%if(usu.getId_gen() == 1){%>Prefiero no Decirlo<%}else if(usu.getId_gen() == 2){%>Femenino<%}else if(usu.getId_gen() == 3){%>Masculino<%} %></h3>
                </div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
            </div>
            <div class="btn">
                <button onclick="mandar(<%=usu.getId_usu()%>)" class="cs" data-open="modal3">Inhabilitar cuenta</button>
                <button onclick="mandardatos(<%=usu.getId_usu()%>,'<%=usu.getNom_usu()%>','<%=usu.getEmail()%>','<%=usu.getId_gen()%>','<%=usu.getFecha_nac()%>')" class="mc" data-open="modal4">Modificar cuenta</button>
                <button class="ch" onclick=" modi(<%=usu.getId_usu()%>)">Consultar historico</button>
            </div>
        </div>
        <% } 
            if(doctores.size() == 0){

            %> 
            <div class="vacio">
            <p>No hay Doctores Registrados Actualmente</p>
            <img src="./img/sindoc.svg">
         </div>
        
        <%
            }
        %>
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
    <div class="modal2" id="modal2">
        <div class="card">
            <form action="../RegistrarDoctor" name="registrarDoc">
                <input type="text" name="nombre" id="name" placeholder="Nombre de Usuario" class="input">
                <input type="email" name="email" id="email" placeholder="Correo electronico" class="input">
                <br>
                <label for="" class="article">Fecha de nacimiento</label><br>
                <input type="date" name="fecha" id="date" class="input">
                <br>
                <label for="" class="article">Sexo</label>
                <br>
                <select name="sexo" id="" class="select">
                <option value="3">Masculino</option>
                <option value="2">Femenino</option>
                <option value="1">Prefiero no decirlo</option>
            </select>
                <input type="password" name="pass" id="password1" placeholder="Contraseña" class="input">
                <input type="password" name="passwordConfirm1" id="passwordConfirm1" placeholder="Confirmar Contraseña" class="input">
                <button type="button" class="submit" onclick="registrardr()">Registrar Doctor</button>
            </form>
        </div>
    </div>
    <div class="modal2" id="modal3">
        <div class="card">
            <form name="deshabilitar" action="../DeshabilitarDoctor"><input type="hidden" name="id" id="id" value=""></form>
            <h4>Cuidado, esta acción podría afectar el flujo del sistema</h4>
            <button class="cs" onclick="Deshabilitar()">Inhabilitar cuenta</button>
            <button class="submit">No inhabilitar cuenta</button>
        </div>
    </div>
    <div class="modal2" id="modal4">
        <div class="card">
                <form action="../ModificarDoctor" name="ModCuentaDoctor">
            <input type="hidden" name="idd" id="idd" value="" >
            <input type="text" name="nombred" id="nombred" placeholder="Nombre de Usuario" class="input" value="">
            <input type="text" name="correod" id="correod" placeholder="Correo electronico" class="input" value="">
            <br>
            <label for="" class="article">Fecha de nacimiento</label><br>
            <input type="date" name="fechad" id="fechad" class="input" value="">
            <br>
            <label for="" class="article">Sexo</label>
            <br>
            <select name="sexod" id="sexod" class="select">
                <option value="3" id="mas">Masculino</option>
                <option value="2" id="fe">Femenino</option>
                <option value="1" id="pre">Prefiero no decirlo</option>
            </select>
            <br>
            <input type="password" name="password" id="password" placeholder="Contraseña" class="input">
            <br>
            <button type="button" class="submit" onclick="modificarcuentadr()">Modificar Cuenta</button>
        </form>
        </div>
    </div>
    <script>
        function Deshabilitar(){
           document.deshabilitar.submit();
        }
        function mandar(id){
            document.getElementById("id").value = id;
        }
        function modi(id){
             location.href = 'consultarHistorico.jsp?id='+id;
        }
        function mandardatos(id, nombre, email, id_gen, fecha){
            document.getElementById("fechad").value = fecha;
            document.getElementById("nombred").value= nombre;
            document.getElementById("correod").value = email;
            document.getElementById("idd").value = id;
            var id_genn = parseInt(id_gen);
            if(id_genn == 1){
                document.getElementById("pre").selected = true;
            }else if(id_genn == 2){
                document.getElementById("fe").selected = true;
            }else if(id_genn == 3){
                document.getElementById("mas").selected = true;
            }
            
        }
    </script>
    <script src="./JS/redirigir.js"></script>
    <script src="./JS/funcionModal2.js"></script>
    <script src="./JS/validar.js"></script>
    <% 
        if(contra == 1){
            %> 
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'No se Modificado el doctor',
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
