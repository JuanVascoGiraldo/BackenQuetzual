
package Servlets;

import Control.GestionarPregunta;
import Control.Validar;
import Modelo.MPregunta;
import Modelo.MUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class HacerPregunta extends HttpServlet {

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
            String pre = request.getParameter("pre");
            HttpSession sesion = request.getSession(true);
            if(sesion.getAttribute("usuario") != null){
                MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
                if(usu.getId_rol() == 1){
                    if(pre != null){
                        if(Validar.Validarpregunta(pre)){
                            //fecha, usuario, pregunta
                            Calendar fecha = java.util.Calendar.getInstance();
                            String fech=fecha.get(java.util.Calendar.DATE) + "/"
                                + (fecha.get(java.util.Calendar.MONTH)+1) + "/" 
                                        + fecha.get(java.util.Calendar.YEAR);
                            MPregunta preg = new MPregunta();
                            preg.setFecha_pre(fech);
                            preg.setDes_pre(pre);
                            preg.setId_usup(usu.getId_usu());
                            if(GestionarPregunta.RealizarPre(preg, usu.getClave(), usu.getToken())){
                                response.sendRedirect("confirmacionUsuario.jsp");
                            }else{
                                response.sendRedirect("paginaError2.html");
                            }
                        }else{
                            response.sendRedirect("hacerPregunta.jsp");
                        }
                    }else{
                        response.sendRedirect("paginaError2.html");
                    }
                }else{
                    response.sendRedirect("index.jsp");
                }
            }else{
                response.sendRedirect("index.jsp");
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
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
