
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


public class ModificarDoctor extends HttpServlet {

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
            int genero, id;
            nombre = request.getParameter("nombred");
            correo = request.getParameter("correod");
            fecha = request.getParameter("fechad");
            genero = Integer.parseInt(request.getParameter("sexod"));
            id = Integer.parseInt(request.getParameter("idd"));
            HttpSession sesion = request.getSession(true);
            if(sesion.getAttribute("usuario")!= null){
                if(nombre != null && correo != null && fecha != null){
                    MUsuario usua = (MUsuario)sesion.getAttribute("usuario");
                    if(usua.getId_rol() == 3){
                        if(Validar.Validarcorreo(correo)&& Validar.Validarfecha(fecha) && Validar.Validarnombre(nombre)){
                                MUsuario usu = new MUsuario();
                                usu.setClave(usua.getClave());
                                usu.setId_rol(2);
                                usu.setId_usu(id);
                                usu.setEmail(correo);
                                usu.setFecha_nac(fecha);
                                usu.setNom_usu(nombre);
                                usu.setId_gen(genero);
                            if(GestionarUsuario.ModificarUsuario(usu)){
                                response.sendRedirect("./Administrador/adminDoctores.jsp");
                            }else{
                                response.sendRedirect("./Administrador/consultarHistorico.jsp?id="+id);
                                
                            }
                        }else{
                            response.sendRedirect("paginaError2.html");
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
