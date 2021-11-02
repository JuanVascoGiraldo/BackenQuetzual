
package Servlets;

import Modelo.MUsuario;
import Control.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class IniciarSesion extends HttpServlet {

    private static final String claveusu = "As7cnuLSSGkw85A8SdrDJmqLHsSJAfqd";
    private static final String clavedoc = "S:sVw>SN?j75zcA#-q{YdZ_5#W{E=X2q";
    private static final String claveadmin = "72eV)'xL9}:NQ999X(MUFa$MTw]$zz;w";
    
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
            String email = request.getParameter("email");
            String contra = request.getParameter("contra");
            HttpSession sesion = request.getSession(true);
            if(sesion.getAttribute("usuario")== null){
                if(email != null && contra != null){
                    if(Validar.Validarcorreo(email)&& Validar.Validarcontra(contra)){
                        MUsuario usu = GestionarUsuario.iniciarSesion(email, contra);
                        if(usu.getNom_usu().equals("No se ha encontrado ningun usuario")){
                            response.sendRedirect("index.jsp");
                        }else{
                            int id = usu.getId_rol();
                            if(id == 1){
                                usu.setClave(claveusu);
                                sesion.setAttribute("usuario", usu);
                                response.sendRedirect("sesionUsuario.jsp");
                            }else if( id== 2){
                                usu.setClave(clavedoc);
                                sesion.setAttribute("usuario", usu);
                                response.sendRedirect("./Doctor/inicioDoctor.jsp");
                            }else if (id == 3){
                                usu.setClave(claveadmin);
                                sesion.setAttribute("usuario", usu);
                                response.sendRedirect("./Administrador/sesionAdmin.jsp");
                            }
                            
                        }
                    }else{
                        response.sendRedirect("paginaError2.html");
                    }
                }else{
                    response.sendRedirect("paginaError2.html");
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
