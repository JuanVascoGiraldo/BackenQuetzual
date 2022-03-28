/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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

/**
 *
 * @author Juanv
 */
public class ModiCorreo extends HttpServlet {

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
            String correo;
            HttpSession sesion = request.getSession(true);
            correo = request.getParameter("correo");
            if(sesion.getAttribute("usuario")!= null){
                MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
                int id = usu.getId_rol();
                if(id == 1){
                    if(correo != null){
                        if(Validar.Validarcorreo(correo)){
                            if(GestionarUsuario.GenerarTokenEmail(usu, correo)){
                                out.println("<script>");
                                    out.println("Swal.fire({");
                                        out.println("icon: 'success',");
                                        out.println("title: 'Correcto',");
                                        out.println("text: 'Se ha enviado el correo de Confirmación'");
                                    out.println(" });");
                                out.println("</script>");
                            }else{
                                out.println("<script>");
                                    out.println("Swal.fire({");
                                          out.println("icon: 'error',");
                                         out.println("title: 'Oops...',");
                                         out.println("text: 'Correo ya registrado'");
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
                }else{
                    response.sendRedirect("index.jsp");
                }
            }else{
               response.sendRedirect("index.jsp");
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
