
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


public class FiltroCat extends HttpServlet {

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
                            if(fil < 0 || fil > 5){
                                fil = 0;
                            }
                        }else{
                            fil = 0;
                        }
                    }else{
                        fil = 0;
                    }
                    List<MPregunta> pre = GestionarPregunta.ConsultarAllPreRes(usu.getClave(), fil );
                    for(MPregunta pres: pre){
                        out.println("<div class=\"main_container\">");
                            out.println("<div class=\"mini_header\">");
                                out.println("<h2>"+pres.getEdad_usu()+" años</h2>");
                                out.println("<h2>"); 
                                    if(pres.getId_catgen() == 1){
                                        out.println("Enfermedades de transmisión sexual");
                                    }else if(pres.getId_catgen() == 2){
                                        out.println("Embarazo");
                                    }else if(pres.getId_catgen() == 3){
                                        out.println("Salud sexual femenina");
                                    }else if(pres.getId_catgen() == 4){
                                        out.println("Salud sexual masculina"); 
                                    }else if(pres.getId_catgen() == 5){
                                        out.println("Anticonceptivos"); 
                                    }
                                out.println("</h2>");
                                out.println("<h2>"+pres.getCantidadRes()+" Respuestas</h2>");
                            out.println("</div>");
                            out.println("<div class=\"pregunta\">");
                                out.println("<img src=\"./img/bxs-user.svg\">");
                                out.println("<div class=\"preguntas\">");
                                    out.println("<h3>"+pres.getDes_pre()+"</h3>");
                                out.println("</div>");
                            out.println("</div>");
                            out.println("<div class=\"respuesta\">");
                                out.println("<a href=\"./respuestasPregunta.jsp?id="+pres.getId_pre()+"&&re=0\">Ver respuestas</a>");
                            out.println("</div>");
                        out.println("</div>");
                    }
                    if(pre.isEmpty()){
                        out.println("<div class=\"vacio\">"); 
                            out.println("<p>No hay Preguntas Actualmente</p>"); 
                            out.println("<img src=\"./img/sinprepuusu.svg\">"); 
                        out.println("</div>"); 
                    }
                }else{
                    response.sendRedirect("index.jsp");
                }
            }else{
                response.sendRedirect("index.jsp");
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
