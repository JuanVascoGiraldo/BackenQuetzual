/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Control.GestionarUsuario;
import Modelo.MUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ValidarToken extends HttpServlet {

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
            String token;
            token = request.getParameter("token");
            HttpSession sesion = request.getSession(true);
            if(sesion.getAttribute("usuario")== null){
                if(token != null){
                    if(GestionarUsuario.ComprobarTokenPass(token)){
                        out.println("<form action=\"CambiarPass\" name=\"reccontra\" style=\"background-color: rgba(252, 252, 252, 0);;\">");
                        out.println("<h4>Modificar Contraseña</h4>");
                        out.println("<input type=\"password\" name=\"contra\" id=\"contra\" class=\"texto\" placeholder=\"Contraseña\">");
                        out.println("<input type=\"password\" name=\"confcontra\" id=\"confcontra\" class=\"texto\" placeholder=\" Confirma la Contraseña\">");
                        out.println("<button type=\"button\" id=\"IniciarSesion\" class=\"submit button\" onclick=\" RecuperarContra()\" style=\"border: 1px solid black;\">Modificar Contraseña</button>");
                        out.println("</form>");
                    }else{
                        out.println("<h4>Token No valido</h4>");
                        out.println("<img src=\"./img/sinprepenusu.svg\" style=\"max-width: 500px; max-height: 500px;\">");
                    }
                }else{
                    out.println("<h4>No se ha ingresado Token</h4>");
                    out.println("<img src=\"./img/sinprepenusu.svg\" style=\"max-width: 500px; max-height: 500px;\">");
                }
            }else{
                MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
                int id = usu.getId_rol();
                if(id == 1){
                    response.sendRedirect("sesionUsuario.jsp");
                }else if( id== 2){
                    response.sendRedirect("./Doctor/inicioDoctor.jsp");
                }else if (id == 3){
                    response.sendRedirect("./Administrador/sesionAdmin.jsp");
                }
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
