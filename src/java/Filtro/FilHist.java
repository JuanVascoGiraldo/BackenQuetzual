
package Filtro;

import Control.GestionarPregunta;
import Control.Validar;
import Modelo.MPregunta;
import Modelo.MPublicacion;
import Modelo.MRespuesta;
import Modelo.MUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class FilHist extends HttpServlet {

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
                if(rol== 2 ){
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
                    int j= 0;
                    List<MPublicacion> publi= GestionarPregunta.ConsultatHistoricoDoc(usu.getId_usu(), usu.getClave(), usu.getToken());
                    if(publi.isEmpty()){
                        String pre = "Preguntas ";
                        if(fil == 1)pre += "Rechazadas ";
                        if(fil == 2)pre += "Respondidas ";
                        out.println("<div class=\"vacio\">");
                            out.println("<p>No hay "+pre+"en el Historico</p>");
                            out.println("<img src=\"./img/sinhis.svg\">");
                        out.println("</div>");
                    }else{
                        for(MPublicacion pu: publi){
                            MPregunta pre = pu.getPregunta();
                            MRespuesta res = pu.getRespuesta();
                            if(pre.getId_estado() == 2 && cat1){
                                j++;
                                out.println("<div class=\"main_container\">");
                                    out.println("<div class=\"mini_header\">");
                                        out.println("<h2>"+pre.getEdad_usu()+" años</h2>");
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
                                        out.println("<h2>"+res.getCali_pro());
                                            out.println("<p class=\"star\">★</p>");
                                        out.println("</h2>");
                                    out.println("</div>");
                                    out.println("<div class=\"sub_header\">");
                                        out.println("<h2>"+pre.getFecha_pre()+" - Respondido: "+res.getFecha_res()+"</h2>");
                                        out.println("<h2>Dr. "+usu.getNom_usu()+"</h2>");
                                    out.println("</div>");
                                    out.println("<div class=\"pregunta\">");
                                        out.println("<img src=\"./img/bxs-user.svg\" class=\"img\">");
                                        out.println("<div class=\"preguntas\">");
                                            out.println("<h3>"+pre.getDes_pre()+"</h3>");
                                        out.println("</div>");
                                    out.println("</div>");
                                    out.println("<div class=\"respuesta\">");
                                        out.println("<div class=\"respuestas\">");
                                            out.println("<h3>"+res.getDes_res()+" </h3>");
                                        out.println("</div>");
                                        out.println("<img src=\"./img/bx-plus-medical.svg\" class=\"img\">");
                                    out.println("</div>");
                                out.println("</div>");
                            }else if(pre.getId_estado() == 3 && cat2){
                                j++;
                                out.println("<div class=\"card\">");
                                    out.println("<div class=\"mini_header2\">");
                                        out.println("<h2><"+res.getFecha_res()+"</h2>");
                                    out.println("</div>");
                                    out.println("<div class=\"pregunta2\">");
                                        out.println("<img src=\"./img/bxs-user.svg\" alt=\"\">");
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
                        if(j==0){
                            String pre = "Preguntas ";
                            if(fil == 1)pre += "Rechazadas ";
                            if(fil == 2)pre += "Respondidas ";
                            out.println("<div class=\"vacio\">");
                                out.println("<p>No hay "+pre+"en el Historico</p>");
                                out.println("<img src=\"./img/sinhis.svg\">");
                            out.println("</div>");
                        }
                        
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
