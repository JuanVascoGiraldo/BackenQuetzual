
package Servlets;

import Control.GestionarUsuario;
import Control.Validar;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CorreoSoporte extends HttpServlet {

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
            String correo, tema, duda;
            correo = request.getParameter("correo");
            tema = request.getParameter("tema");
            duda = request.getParameter("duda");
            if(correo != null && tema != null && duda != null){
                if(Validar.Validarcorreo(correo) && Validar.ValidarTema(tema) && Validar.Validarpregunta(duda)){
                    Calendar fecha = java.util.Calendar.getInstance();
                    String fecha_dud=fecha.get(java.util.Calendar.DATE) + "/"
                        + (fecha.get(java.util.Calendar.MONTH)+1) + "/" 
                                + fecha.get(java.util.Calendar.YEAR);
                    if(GestionarUsuario.Soporte(correo, fecha_dud, tema, duda)){
                        out.println("<script>");
                            out.println("Swal.fire({");
                                out.println("icon: 'success',");
                                out.println("title: 'Correcto',");
                                out.println("text: 'Se ha enviado el correo de confimación'");
                            out.println(" });");
                            out.println("crm()");
                        out.println("</script>");
                    }else{
                        out.println("<script>");
                            out.println("Swal.fire({");
                                out.println("icon: 'error',");
                                out.println("title: 'Oops...',");
                                out.println("text: 'Ocurrio un error intentalo de nuevo'");
                            out.println(" });");
                        out.println("</script>");
                    }
                }else{
                    out.println("<script>");
                        out.println("Swal.fire({");
                              out.println("icon: 'error',");
                             out.println("title: 'Oops...',");
                             out.println("text: 'Ingresa Caracteres validos'");
                        out.println(" });");
                    out.println("</script>");
                }
            }else{
                out.println("<script>");
                    out.println("Swal.fire({");
                        out.println("icon: 'error',");
                        out.println("title: 'Oops...',");
                        out.println("text: 'Rellena Todos los Campos'");
                    out.println(" });");
                out.println("</script>");
            }
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
