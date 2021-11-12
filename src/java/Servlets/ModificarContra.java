
package Servlets;

import Control.GestionarUsuario;
import Control.Validar;
import Modelo.MUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class ModificarContra extends HttpServlet {

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
             String pass, newpass;
             pass = request.getParameter("pass");
             newpass = request.getParameter("newpass");
             HttpSession sesion = request.getSession(true);
             if(sesion.getAttribute("usuario")!= null){
                 if(pass != null && newpass != null){
                    if(Validar.Validarcontra(pass)&&Validar.Validarcontra(newpass)){
                        MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
                        if(pass.equals(usu.getContra())){
                            if(GestionarUsuario.ModificarContra(newpass, usu.getId_usu(), usu.getId_rol(), usu.getClave(), usu.getToken())){
                                response.sendRedirect("CerrarSesion");
                            }else{
                                if(usu.getId_rol() == 1){
                                response.sendRedirect("cuenta.jsp?contra=1");
                            }else if(usu.getId_rol() == 3){
                                response.sendRedirect("./Administrador/cuentaAdmin.jsp?contra=1");
                            }
                            }
                        }else{
                            if(usu.getId_rol() == 1){
                                response.sendRedirect("cuenta.jsp?contra=1");
                            }else if(usu.getId_rol() == 3){
                                response.sendRedirect("./Administrador/cuentaAdmin.jsp?contra=1");
                            }
                        }
                    }else{
                        response.sendRedirect("paginaError2.html");
                    }
                 }else{
                     response.sendRedirect("paginaError2.html");
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
