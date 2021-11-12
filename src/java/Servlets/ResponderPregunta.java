
package Servlets;

import Control.GestionarPregunta;
import Control.Validar;
import Modelo.MPregunta;
import Modelo.MRespuesta;
import Modelo.MUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class ResponderPregunta extends HttpServlet {

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
            if(sesion.getAttribute("usuario")!=null){
                MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
                if(usu.getId_rol() == 2){
                    String des_pre, des_res, fecha_pre, fecha_res;
                    int id_pre, id_cat;
                    des_pre = request.getParameter("des_pre");
                    des_res = request.getParameter("des_res");
                    fecha_pre = request.getParameter("fecha_pre");
                    id_pre = Integer.valueOf(request.getParameter("id_pre"));
                    id_cat = Integer.valueOf(request.getParameter("id_cat"));
                    if(des_pre != null && des_res != null && fecha_pre != null){
                        if(Validar.Validarpregunta(des_res) && Validar.Validarpregunta(des_pre) && Validar.ValidarfechaPre(fecha_pre)){
                            Calendar fecha = java.util.Calendar.getInstance();
                            fecha_res=fecha.get(java.util.Calendar.DATE) + "/"
                                + (fecha.get(java.util.Calendar.MONTH)+1) + "/" 
                                        + fecha.get(java.util.Calendar.YEAR);
                            MPregunta pre = new MPregunta();
                            MRespuesta res = new MRespuesta();
                            pre.setDes_pre(des_pre);
                            pre.setId_pre(id_pre);
                            res.setId_usuRes(usu.getId_usu());
                            res.setFecha_res(fecha_res);
                            res.setDes_res(des_res);
                            res.setId_cat(id_cat);
                            pre.setFecha_pre(fecha_pre);
                            if(GestionarPregunta.ResponderPre(pre, res, usu.getClave(), usu.getToken())){
                                response.sendRedirect("./Doctor/preguntasPendientes.jsp");
                            }else{
                                response.sendRedirect("./Doctor/responderPregunta.jsp?id="+id_pre);
                            }
                        }else{
                            response.sendRedirect("./Doctor/responderPregunta.jsp?id="+id_pre);
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
