
package Filtro;

import Control.GestionarUsuario;
import Control.Validar;
import Modelo.MUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FiltroRanking extends HttpServlet {

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
                if(usu.getId_rol() == 2 || usu.getId_rol() ==3){
                    int fil;
                    if(request.getParameter("filtro")!= null){
                        if(Validar.ValidarFiltro(request.getParameter("filtro"))){
                            fil = Integer.valueOf(request.getParameter("filtro"));
                            if(fil < 1 || fil > 2){
                                fil = 1;
                            }
                        }else{
                            fil = 1;
                        }
                    }else{
                        fil = 1;
                    }
                    List<MUsuario> usuarios = new ArrayList<MUsuario>();
                    if(fil == 1){
                        usuarios = GestionarUsuario.ObtenerRankingHistorico(usu.getClave(), usu.getToken());
                    }else if(fil == 2){
                        Calendar fecha = java.util.Calendar.getInstance();
                        String fech=(fecha.get(java.util.Calendar.MONTH)+1) + "/" 
                                    + fecha.get(java.util.Calendar.YEAR);
                        usuarios = GestionarUsuario.ObtenerRankingMensual(fech, usu.getClave());
                    }
                    if(usuarios.isEmpty()){
                        String filt = "";
                        if(fil == 1){
                            filt = "Historico";
                        }else{
                            filt = "Mensual";
                        }
                        out.println("<div class=\"vacio\">");
                        out.println("<p>No hay Ranking "+filt+" Actualmente</p>");
                        out.println("<img src=\"./img/sinrakmen.svg\">");
                        out.println(" </div>");
                    }else{
                        out.println("<div class=\"encabezado\">");
                            out.println("<div class=\"doctores\">Doctores</div>");
                            out.println("<div class=\"puntos\">Puntos</div>");
                        out.println("</div>");
                        int i=0;
                        for(MUsuario usua:usuarios){
                           i++;
                           if(i>3){
                               out.println("<div class=\"participante\">");
                                    out.println("<div class=\"doctores\">"+i+". Dr."+usua.getNom_usu()+"</div>");
                                    out.println("<div class=\"puntos\">"+usua.getPuntos()+" 🏆</div>");
                                out.println("</div>");
                           }else if(i==3){
                               out.println("<div class=\"tercero\">");
                                    out.println("<div class=\"doctores\">"+i+". Dr."+usua.getNom_usu()+"</div>");
                                    out.println("<div class=\"puntos\">"+usua.getPuntos()+" 🏆</div>");
                                out.println("</div>");
                           }else if(i==2){
                               out.println("<div class=\"segundo\">");
                                    out.println("<div class=\"doctores\">"+i+". Dr."+usua.getNom_usu()+"</div>");
                                    out.println("<div class=\"puntos\">"+usua.getPuntos()+" 🏆</div>");
                                out.println("</div>");
                           }else if(i==1){
                                out.println("<div class=\"primero\">");
                                    out.println("<div class=\"doctores\">"+i+". Dr."+usua.getNom_usu()+"</div>");
                                    out.println("<div class=\"puntos\">"+usua.getPuntos()+" 🏆</div>");
                                out.println("</div>");
                           }
                        }
                    }
                
                }else{
                    response.sendRedirect("../index.jsp");
                }
            }else{
                response.sendRedirect("../index.jsp");
            }
        }catch(Exception e){
            response.sendRedirect("../index.jsp");
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
