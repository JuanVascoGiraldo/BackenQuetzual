package Filtro;

import Modelo.MUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import Control.*;
import Modelo.*;

public class FiltroPreguntasUsu extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession sesion = request.getSession(true);
            if(sesion.getAttribute("usuario")!= null){
                MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
                if(usu.getId_rol() == 1){
                    int fil;
                    if(request.getParameter("filtro")!= null){
                        if(Validar.ValidarFiltro(request.getParameter("filtro"))){
                            fil = Integer.valueOf(request.getParameter("filtro"));
                            if(fil < 1 || fil > 3){
                                fil = 3;
                            }
                        }else{
                            fil = 3;
                        }
                    }else{
                        fil = 3;
                    }
                    if(fil == 1){
                        out.println("<div class=\"title\">");
                            out.println("<h1>Preguntas Respondidas</h1>");
                            out.println("<hr>");
                        out.println("</div>");
                        List<MPregunta> pres = GestionarPregunta.ConsultarPreResUsu(usu.getId_usu(), usu.getClave(), usu.getFecha_nac(), usu.getToken());
                        for(MPregunta pre:pres){
                            out.println("<div class=\"main_containerRe\">");
                                out.println("<div class=\"mini_headerRe\">");
                                    out.println("<h2 class=\"h2\">"+pre.getEdad_usu()+" Años</h2>");
                                    out.println("<h2 class=\"h2\">");
                                        if(pre.getId_catgen() == 1){
                                            out.println("Enfermedades de transmisión sexual");
                                         }else if(pre.getId_catgen() == 2){
                                            out.println("Embarazo");
                                         }else if(pre.getId_catgen() == 3){
                                            out.println("Salud sexual femenina");
                                         }else if(pre.getId_catgen() == 4){
                                            out.println("Salud sexual masculina");
                                         }else if(pre.getId_catgen() == 5){
                                            out.println("Anticonceptivos");
                                         }
                                    out.println("</h2>");
                                    out.println("<h2 class=\"h2\">"+pre.getCantidadRes()+" Respuestas</h2>");
                                out.println("</div>");
                                out.println("<div class=\"preguntaRe\">");
                                    out.println("<img src=\"./img/bxs-user.svg\" alt=\"\">");
                                    out.println("<div class=\"preguntasRe\">");
                                        out.println("<h3 class=\"h3\">"+pre.getDes_pre()+"</h3>");
                                    out.println("</div>");
                                out.println("</div>");
                                out.println("<div class=\"respuestaRe\">");
                                    out.println("<a href=\"./respuestasPregunta.jsp?id="+pre.getId_pre()+"&&re=1\" class=\"aRe\">Ver respuestas</a>");
                                out.println("</div>");
                            out.println("</div>");
                        }
                        if(pres.isEmpty()){
                            out.println("<div class=\"vacio\">");
                            out.println("<p>No Tienes Preguntas Respondidas Actualmente</p>");
                            out.println("<img src=\"./img/sinpreresusu.svg\">");
                            out.println("</div>");
                         }
                    }else if( fil == 2){
                        out.println("<div class=\"title\">");
                            out.println("<h1>Preguntas rechazadas</h1>");
                            out.println("<hr>");
                            out.println("<p>En este espacio puedes consultar las preguntas que han sido rechazadas por los doctores.</p>");
                        out.println("</div>");
                        List<MPublicacion> lista = GestionarPregunta.ConsultarPreRecUsu(usu.getId_usu(), usu.getClave(), usu.getToken());
                        for(MPublicacion publi: lista){
                            MPregunta pre = publi.getPregunta();
                            MRespuesta res = publi.getRespuesta();
                            out.println("<div class=\"cardR\">");
                                out.println("<div class=\"mini_headerR\">");
                                    out.println("<h2 class=\"h2\">"+res.getFecha_res()+"</h2>");
                                out.println("</div>");
                                out.println("<div class=\"preguntaR\">");
                                    out.println("<img src=\"./img/bxs-user.svg\" alt=\"\">");
                                    out.println("<div class=\"preguntasR\">");
                                        out.println("<h3>"+pre.getDes_pre()+"</h3>");
                                    out.println("</div>");
                                    out.println("<h1 class=\"h1R\">Razón del rechazo</h1>");
                                    out.println("<div class=\"preguntasR\">");
                                        out.println("<h3>"+res.getDes_res()+"</h3>");
                                    out.println("</div>");
                                out.println("</div>");
                            out.println("</div>");
                        }
                        if(lista.isEmpty()){
                            out.println("<div class=\"vacio\">");
                                out.println("<p>No Tienes Preguntas Rechazadas Actualmente</p>");
                                out.println("<img src=\"./img/sinprerechusu.svg\">");
                            out.println("</div>");
                        }
                        
                    }else if(fil == 3){
                        out.println("<div class=\"title\">");
                            out.println("<h1>Preguntas Pendientes</h1>");
                            out.println("<hr>");
                            out.println("<p>En este espacio puedes consultar tus preguntas que están en espera de recibir respuesta</p>");
                        out.println("</div>");
                        List<MPregunta> pres = GestionarPregunta.ConsultarPrePenUsu(usu.getId_usu(), usu.getClave(), usu.getToken());
                        for(MPregunta pre:pres){
                            out.println("<div class=\"main_container\">");
                                out.println("<div class=\"mini_header\">");
                                    out.println("<h2>Pendiente</h2>");
                                out.println("</div>");
                                out.println("<div class=\"sub_header\">");
                                    out.println("<h2>"+pre.getFecha_pre()+" - Respondido: Por definir</h2>");
                                    out.println("<h2>Dr. Por Definir</h2>");
                                out.println("</div>");
                                    out.println("<div class=\"pregunta\">");
                                        out.println("<div class=\"preguntas\">");
                                            out.println("<p class=\"text\">"+pre.getDes_pre()+"</p>");
                                        out.println("</div>");
                                    out.println("</div>");
                                    out.println("<div class=\"pregunta\">");
                                        out.println("<button class=\"cs\" onclick=\"redeliminar("+pre.getId_pre()+")\">Eliminar pregunta</button>");
                                        out.println("<button class=\"question\" data-open=\"modalR\" onclick=\"redModi("+pre.getId_pre()+")\" >Modificar Pregunta</button>"); 
                                    out.println("</div>");
                            out.println("</div>");
                        }
                        if(pres.isEmpty()){
                            out.println("<div class=\"vacio\">");
                                out.println("<p>No Tienes Preguntas Actualmente</p>");
                                out.println("<img src=\"./img/sinprepenusu.svg\">");
                            out.println("</div>");
                        }
                        
                    }
                    
                }else{
                    out.println("<script>location.href='index.jsp'</script>");
                }
            }else{
                out.println("<script>location.href='index.jsp'</script>");
            }
            
            
            
        }catch(Exception e){
            System.out.println(e.getCause());
            response.sendRedirect("paginaError2.html");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
