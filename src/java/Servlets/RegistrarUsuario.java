
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Modelo.*;
import Control.*;
import javax.servlet.http.HttpSession;

public class RegistrarUsuario extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()){
            String nombre, correo, contra, fecha;
            int genero;
            nombre = request.getParameter("nombre");
            correo = request.getParameter("correo");
            contra = request.getParameter("contra");
            fecha = request.getParameter("fecha");
            String gen=  request.getParameter("sexo");
            HttpSession sesion = request.getSession(true);
            if(sesion.getAttribute("usuario")== null){
                if(nombre != null && correo != null && contra != null && fecha != null && gen != null){
                    if(Validar.Validarcorreo(correo)&& Validar.Validarcontra(contra) &&
                            Validar.Validarfecha(fecha) && Validar.Validarnombre(nombre) && Validar.ValidarGenero(gen)){
                            genero = Integer.parseInt(request.getParameter("sexo"));
                            MUsuario usu = new MUsuario();
                            usu.setContra(contra);
                            usu.setEmail(correo);
                            usu.setFecha_nac(fecha);
                            usu.setNom_usu(nombre);
                            usu.setId_gen(genero);
                        if(GestionarUsuario.CrearUsuario(usu)){
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
