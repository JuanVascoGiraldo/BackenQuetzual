/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Filtro;

import Control.GestionarPregunta;
import Control.GestionarUsuario;
import Control.Validar;
import Modelo.MPregunta;
import Modelo.MPublicacion;
import Modelo.MRespuesta;
import Modelo.MUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class FilHistAdm extends HttpServlet {

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
            if(sesion.getAttribute("usuario")!= null){
                MUsuario usu = (MUsuario)sesion.getAttribute("usuario");
                int rol = usu.getId_rol();
                if(rol== 3 ){
                    if(request.getParameter("id") != null){
                        if(Validar.ValidarFiltro(request.getParameter("id"))){
                            int id = Integer.valueOf(request.getParameter("id"));
                            int fil = 0;
                            if(request.getParameter("filtro") != null){
                                if(Validar.ValidarFiltro(request.getParameter("filtro"))){
                                    fil = Integer.valueOf(request.getParameter("filtro"));
                                    if(fil<0 || fil>2){
                                        fil = 0;
                                    }
                                }
                            }
                            boolean cat1=false, cat2=false;
                            if(fil == 0 || fil == 1)cat2= true;
                            if(fil == 0 || fil == 2)cat1= true;
                            List<MPublicacion> publi= GestionarPregunta.ConsultatHistoricoDoc(id, usu.getClave(), usu.getToken());
                            if(publi.isEmpty()){
                                String pre = "Preguntas ";
                                if(fil == 1)pre += "Rechazadas ";
                                if(fil == 2)pre += "Respondidas ";
                                out.println("<div class=\"vacio\">");
                                    out.println("<p>No hay "+pre+"en el Historico</p>");
                                    out.println("<img src=\"./img/sinhis.svg\">");
                                out.println("</div>");
                            }else{
                                DecimalFormat formato2 = new DecimalFormat("#.##");
                                MUsuario usus = GestionarUsuario.consultarDoctor(id, usu.getClave(), usu.getToken());
                                for(MPublicacion pu: publi){
                                    MPregunta pre = pu.getPregunta();
                                    MRespuesta res = pu.getRespuesta();
                                    if(pre.getId_estado() == 2 && cat1){
                                        out.println("<div class=\"card\">");
                                            out.println("<div class=\"main_container\">");
                                                out.println("<div class=\"mini_header\">");
                                                    out.println("<h2>"+pre.getEdad_usu() +" años</h2>");
                                                    out.println("<h2>");
                                                        if(res.getId_cat() == 1){
                                                           out.println("Enfermedades de transmisión sexual");
                                                        }else if(res.getId_cat() == 2){
                                                           out.println("Embarazo");
                                                        }else if(res.getId_cat() == 3){
                                                           out.println("Salud sexual femenina");
                                                        }else if(res.getId_cat() == 4){
                                                           out.println("Salud sexual masculina");
                                                        }else if(res.getId_cat() == 5){
                                                           out.println("Anticonceptivos");
                                                        }
                                                    out.println("</h2>");
                                                    out.println("<h2>"+formato2.format(res.getCali_pro()));
                                                        out.println("<p class=\"star\">★</p>");
                                                    out.println("</h2>");
                                                out.println("</div>");
                                                out.println("<div class=\"sub_header\">");
                                                    out.println("<h2>"+pre.getFecha_pre()+"  - Respondido: "+res.getFecha_res() +"</h2>");
                                                    out.println("<h2>Dr."+ usus.getNom_usu()+"</h2>");
                                                out.println("</div>");
                                                out.println("<div class=\"pregunta\">");
                                                    out.println("<img src=\"./img/bxs-user.svg\" class=\"img\">");
                                                    out.println("<div class=\"preguntas\">");
                                                        out.println("<h3>"+pre.getDes_pre()+"</h3>");
                                                    out.println("</div>");
                                                out.println("</div>");
                                                out.println("<div class=\"respuesta\">");
                                                    out.println("<div class=\"respuestas\">");
                                                        out.println("<h3>"+res.getDes_res()+"</h3>");
                                                    out.println("</div>");
                                                    out.println("<img src=\"./img/bx-plus-medical.svg\" class=\"img\">");
                                                out.println("</div>");
                                            out.println("</div>");
                                        out.println("</div>");
                                    }else if(pre.getId_estado() == 3 && cat2){
                                        out.println("<div class=\"card\">");
                                            out.println("<div class=\"mini_header2\">");
                                                out.println("<h2>"+res.getFecha_res()+"</h2>");
                                            out.println("</div>");
                                            out.println("<div class=\"pregunta2\">");
                                                out.println("<div class=\"preguntas2\">");
                                                    out.println("<h3>"+pre.getDes_pre()+"</h3>");
                                                out.println("</div>");
                                                out.println("<h1 class=\"h1\">Razón del rechazo</h1>");
                                                out.println("<div class=\"preguntas2\">");
                                                    out.println("<h3>"+res.getDes_res()+"</h3>");
                                                out.println("</div>");
                                            out.println("</div>");
                                        out.println("</div>");
                                    }
                                }
                            }
                        }else{
                            out.println("<script>");
                            out.println("location.href= 'adminDoctores.jsp'");
                            out.println("</script>");
                        }
                    }else{
                        out.println("<script>");
                        out.println("location.href= 'adminDoctores.jsp'");
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
