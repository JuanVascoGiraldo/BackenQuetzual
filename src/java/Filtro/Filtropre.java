
package Filtro;

import Control.GestionarPregunta;
import Control.Validar;
import Modelo.MPregunta;
import Modelo.MUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Filtropre extends HttpServlet {

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
                if(usu.getId_rol() == 2){
                    int fil = 1;
                    if(request.getParameter("filtro") != null){
                        if(Validar.ValidarFiltro(request.getParameter("filtro"))){
                            fil = Integer.valueOf(request.getParameter("filtro"));
                            if(fil<1 || fil>2){
                                fil = 1;
                            }
                        }else{
                            fil = 1;
                        }
                    }else{
                        fil = 1;
                    }
                    System.out.println("miau");
                    if(fil == 1){
                        List<MPregunta> lista = GestionarPregunta.ConsultarallPrePen(usu.getClave(), usu.getToken());
                        if(lista.isEmpty()){
                            out.println("<div class=\"vacio\">");
                                out.println("<p>No hay Preguntas Pendientes Actualmente</p>");
                                out.println("<img src=\"./img/sinprependoc.svg\">");
                            out.println("</div>");
                        }else{
                            for(MPregunta pre: lista){
                                out.println("<div class=\"main_container\">");
                                    out.println("<div class=\"mini_header2\">");
                                        out.println("<h2>"+pre.getFecha_pre()+"</h2>");
                                    out.println("</div>");
                                    out.println("<div class=\"pregunta\">");
                                        out.println("<img src=\"./img/bxs-user.svg\" alt=\"\">");
                                        out.println("<textarea name=\"\" id=\"\" class=\"area\" placeholder=\"Escribe aquí tu pregunta\" disabled>"+pre.getDes_pre()+"</textarea>");
                                    out.println("</div>");
                                    out.println("<div class=\"flex\">");
                                        out.println("<button class=\"question\" onclick=\"responder('"+pre.getId_pre()+"')\">Responder pregunta</button>");
                                        out.println("<button class=\"cs\" onclick=\"rechazar('"+pre.getId_pre()+"')\">Rechazar pregunta</button>");
                                    out.println("</div>");
                                out.println("</div>");
                            }
                        }
                         
                    }else if(fil == 2){
                        List<MPregunta> pre = GestionarPregunta.ConsultarAllPreRes(usu.getClave(), 0);
                        if(pre.isEmpty()){
                            out.println("<div class=\"vacio\">");
                                out.println("<p>No hay Preguntas Respondidas Actualmente</p>");
                                out.println("<img src=\"./img/sinprependoc.svg\">");
                            out.println("</div>");
                        }else{
                            for(MPregunta res: pre){
                                out.println("<div class=\"main_containerR\">");
                                    out.println("<div class=\"mini_headerR\">");
                                        out.println("<h2>"+res.getEdad_usu()+" años</h2>");
                                        out.println("<h2>");
                                            if(res.getId_catgen() == 1){
                                            out.println("Enfermedades de transmisión sexual");
                                            }else if(res.getId_catgen() == 2){
                                               out.println("Embarazo");
                                            }else if(res.getId_catgen() == 3){
                                               out.println("Salud sexual femenina");
                                            }else if(res.getId_catgen() == 4){
                                               out.println("Salud sexual masculina");
                                            }else if(res.getId_catgen() == 5){
                                               out.println("Anticonceptivos");
                                            }
                                        out.println("</h2>");
                                        out.println("<h2>"+res.getCantidadRes()+" Respuestas</h2>");
                                    out.println("</div>");
                                    out.println("<div class=\"preguntaR\">");
                                        out.println("<img src=\"./img/bxs-user.svg\">");
                                        out.println("<div class=\"preguntasR\">");
                                            out.println("<h3>"+res.getDes_pre()+"</h3>");
                                        out.println("</div>");
                                    out.println("</div>");
                                    out.println("<div class=\"respuestaR\">");
                                        out.println("<a href=\"./respuestasPregunta.jsp?id="+res.getId_pre()+"\">Ver respuestas</a>");
                                    out.println("</div>");
                                out.println("</div>");
                            }
                        }
                        
                    }
                
                }else{
                    response.sendRedirect("../index.jsp");
                }
            }else{
                response.sendRedirect("../index.jsp");
            }
        }catch(Exception e){
            response.sendRedirect("../index.jsp");
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
