
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


public class RegistrarDoctor extends HttpServlet {

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
            String nombre, correo, contra, fecha;
            int genero;
            nombre = request.getParameter("nombre");
            correo = request.getParameter("email");
            contra = request.getParameter("pass");
            fecha = request.getParameter("fecha");
            genero = Integer.parseInt(request.getParameter("sexo"));
            HttpSession sesion = request.getSession(true);
            if(sesion.getAttribute("usuario")!= null){
                MUsuario usua = (MUsuario)sesion.getAttribute("usuario");
                if(usua.getId_rol()==3){
                    if(nombre != null && correo != null && contra != null && fecha != null){
                        if(Validar.Validarcorreo(correo)&& Validar.Validarcontra(contra) &&
                                Validar.Validarfecha(fecha) && Validar.Validarnombre(nombre)){
                                MUsuario usu = new MUsuario();
                                usu.setContra(contra);
                                usu.setEmail(correo);
                                usu.setFecha_nac(fecha);
                                usu.setNom_usu(nombre);
                                usu.setId_gen(genero);
                            if(GestionarUsuario.CrearDoctor(usu, usua.getClave())){
                                response.sendRedirect("./Administrador/adminDoctores.jsp");
                            }else{
                                 response.sendRedirect("./Administrador/adminDoctores.jsp?correo=1");
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
