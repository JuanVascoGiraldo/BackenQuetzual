
package Control;

import Modelo.*;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

public class GestionarPregunta {
    
    public static boolean RealizarPre(MPregunta pre, String clave){
        boolean guardar = false;
        try{
            //pregunta, clave, fecha, usu, estado
            JSONObject jo = new JSONObject();
            jo.put("pregunta", pre.getDes_pre());
            jo.put("clave", clave);
            jo.put("fecha", pre.getFecha_pre());
            jo.put("usu", pre.getId_usup());
            jo.put("estado", 1);
            String url = "/quetzual/pregunta/Realizar/Pregunta";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Guardado")){
                guardar = true;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            guardar = false;
        }
        return guardar;
    }
    
    public static boolean ModificarPre(MPregunta pre, String clave){
        boolean Modi = false;
        try{
            //pregunta, clave, fecha, usu, id_pre
            JSONObject jo = new JSONObject();
            jo.put("pregunta", pre.getDes_pre());
            jo.put("clave", clave);
            jo.put("fecha", pre.getFecha_pre());
            jo.put("usu", pre.getId_usup());
            jo.put("id_pre", pre.getId_pre());
            String url = "/quetzual/pregunta/Modificar/Pregunta/Pendiente";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Actualizado")){
                Modi = true;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            Modi = false;
        }
        return Modi;
    }
    
    public static boolean ElimiarPre (int pre, int id, String clave){
        boolean eli =  false;
        try{
            //clave, pregunta, id_usu
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("pregunta", pre);
            jo.put("id_usu", id);
            String url = "/quetzual/pregunta/Eliminar/Pregunta";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Eliminada")){
                eli = true;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            eli = false;
        }
        return eli;
    }
    
    public static List<MPublicacion> ConsultarPreRecUsu(int id, String clave){
        List<MPublicacion> lista = new ArrayList<MPublicacion>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("id_usu", id);
            jo.put("estado", 3);
            String url = "/quetzual/pregunta/Usuario/Preguntas";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontradas")){
                JSONArray ja= jr.getJSONArray("datos");
                for(int i= 0; i<ja.length(); i++){
                    JSONObject jason = ja.getJSONObject(i);
                    MPregunta pre = new MPregunta();
                    MRespuesta res = new MRespuesta();
                    pre.setDes_pre(jason.getString("des_pre"));
                    pre.setFecha_pre(jason.getString("fecha_pre"));
                    res.setDes_res(jason.getString("des_res"));
                    res.setFecha_res(jason.getString("fecha_res"));
                    MPublicacion publi = new MPublicacion();
                    publi.setPregunta(pre);
                    publi.setRespuesta(res);
                    lista.add(publi);
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return lista;
    }
    
    public static List<MPregunta> ConsultarPrePenUsu(int id,  String clave){
        List<MPregunta> lista = new ArrayList<MPregunta>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("id_usu", id);
            jo.put("estado", 1);
            String url = "/quetzual/pregunta/Usuario/Preguntas";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontradas")){
                JSONArray ja= jr.getJSONArray("datos");
                System.out.println(ja.length());
                for(int i= 0; i<ja.length(); i++){
                    JSONObject jason = ja.getJSONObject(i);
                    MPregunta pre = new MPregunta();
                    pre.setDes_pre(jason.getString("des_pre"));
                    pre.setId_pre(jason.getInt("id_pre"));
                    pre.setFecha_pre(jason.getString("Fecha_pre"));
                    lista.add(pre);
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        System.out.println(lista.size());
        return lista;
    }
    
    public static List<MPregunta> ConsultarPreResUsu(int id, String clave, String fechas){
        List<MPregunta> lista = new ArrayList<MPregunta>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("id_usu", id);
            jo.put("estado", 2);
            String url = "/quetzual/pregunta/Usuario/Preguntas";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontradas")){
                JSONArray ja= jr.getJSONArray("datos");
                for(int i= 0; i<ja.length(); i++){
                    JSONObject jason = ja.getJSONObject(i);
                    MPregunta pre = consultarPre(jason.getInt("id_pre"));
                    pre.setDes_pre(jason.getString("des_pre"));
                    pre.setId_pre(jason.getInt("id_pre"));
                    pre.setFecha_pre(jason.getString("Fecha_pre"));
                    String[] fecha = fechas.split("-");
                    int edad = 0;
                    try{
                        edad = calcularEdad(Integer.valueOf(fecha[0]),Integer.valueOf(fecha[1]), Integer.valueOf(fecha[2]));
                    }catch(Exception e){
                        System.out.println(e.getMessage());
                    }
                    pre.setEdad_usu(edad);
                    lista.add(pre);
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        System.out.println("tamaño lista:" + lista.size());
        return lista;
    }
    
    public static boolean ResponderPre (MPregunta pre, MRespuesta res, String clave){
        boolean resp = false;
        try{
            int puntos = 0;
            String fechpre[]= pre.getFecha_pre().split("/");
            String fechres[]= res.getFecha_res().split("/");
            int diapre = Integer.valueOf(fechpre[0]);
            int diares = Integer.valueOf(fechres[0]);
            if(diapre > diares){
                int mespre = Integer.valueOf(fechpre[1]);
                int dias = 0;
                if(mespre == 1 || mespre == 3 || mespre == 5 || mespre == 7 || mespre == 8 || mespre == 10 || mespre == 12){
                    dias = 31;
                }else if(mespre == 4 || mespre == 6 || mespre == 9 || mespre == 11){
                    dias = 30;
                }else if(mespre == 2){
                    dias = 28;
                }
                if(diares-(dias-diapre) <= 1){
                    puntos = 2;
                }else{
                    puntos = 1;
                }
            }else if(diares-diapre <= 1){
                puntos = 2;
            }else{
                puntos = 1;
            }
            //id_pre, id_doc, fecha, respuesta, pregunta, clave, categoria 
            JSONObject jo = new JSONObject();
            jo.put("id_pre", pre.getId_pre());
            jo.put("id_doc", res.getId_usuRes());
            jo.put("fecha", res.getFecha_res());
            jo.put("respuesta", res.getDes_res());
            jo.put("pregunta", pre.getDes_pre());
            jo.put("clave", clave);
            jo.put("categoria", res.getId_cat());
            jo.put("puntos", puntos);
            String url = "/quetzual/respuesta/Pregunta/Responder";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Pregunta Guardada")){
                resp = true;
            }
        }catch(Exception e){
            resp = false;
            System.out.println(e.getMessage());
        }
        return resp;
    }
    
     public static boolean ResponderPreRes (String res, String fecha, int usu, int pre, String clave){
        boolean resp = false;
        try{
            //clave, id_doc, respuesta, id_pre, fecha
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("id_doc", usu);
            jo.put("respuesta", res);
            jo.put("id_pre",pre);
            jo.put("fecha", fecha);
            String url = "/quetzual/respuesta/Responder/Pregunta/Respondida";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Pregunta Guardada")){
                resp = true;
            }
        }catch(Exception e){
            resp = false;
            System.out.println(e.getMessage());
        }
        return resp;
    }
     
    public static boolean RechazarPre (int pre, MRespuesta res, String clave){
        boolean resp = false;
        try{
            //id_pre, id_doc, fecha, razon, pregunta, clave
            JSONObject jo = new JSONObject();
            jo.put("id_pre", pre);
            jo.put("id_doc", res.getId_usuRes());
            jo.put("fecha", res.getFecha_res());
            jo.put("razon", res.getDes_res());
            jo.put("clave", clave);
            String url = "/quetzual/respuesta/Pregunta/Rechazar";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Rechazada")){
                resp = true;
            }
        }catch(Exception e){
            resp = false;
            System.out.println(e.getMessage());
        }
        return resp;
    }
    
    public static List<MPregunta> ConsultarAllPreRes(String clave){
        List<MPregunta> lista = new ArrayList<MPregunta>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("Clave", clave);
            String url = "/quetzual/pregunta/Respondidas/Actuales";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontrados")){
                //mpregunta.id_pre, mpregunta.des_pre, mpregunta.fecha_pre, musuario.fecha_nac 
                JSONArray ja = jr.getJSONArray("datos");
                for(int i=0; i<ja.length(); i++){
                    JSONObject jso = ja.getJSONObject(i);
                    MPregunta pre = consultarPre(jso.getInt("id_pre"));
                    pre.setDes_pre(jso.getString("des_pre"));
                    pre.setFecha_pre(jso.getString("fecha_pre"));
                    pre.setId_pre(jso.getInt("id_pre"));
                    String fecha[] = jso.getString("fecha_nac").split("-");
                    pre.setEdad_usu(calcularEdad(Integer.valueOf(fecha[0]),Integer.valueOf(fecha[1]), Integer.valueOf(fecha[2])));
                    lista.add(pre);
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return lista;
    }
    
    public static List<MPregunta> ConsultarallPrePen(String clave){
        List<MPregunta> lista = new ArrayList<MPregunta>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            String url = "/quetzual/pregunta/Pendientes";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontradas")){
                JSONArray ja = jr.getJSONArray("datos");
                for(int i=0 ; i<ja.length(); i++){
                    JSONObject jso = ja.getJSONObject(i);
                    MPregunta pre = new MPregunta();
                    pre.setDes_pre(jso.getString("des_pre"));
                    pre.setFecha_pre(jso.getString("Fecha_pre"));
                    pre.setId_pre(jso.getInt("id_pre"));
                    lista.add(pre);
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return lista;
    }
    
    public static List<MPublicacion> ConsultatHistoricoDoc(int id, String clave){
        List<MPublicacion> lista = new ArrayList<MPublicacion>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("id", id);
            jo.put("clave", clave);
            String url = "/quetzual/respuesta/Historico/Doctor";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontradas")){
                JSONArray ja= jr.getJSONArray("datos");
                for(int i= 0; i<ja.length(); i++){
                    JSONObject jason = ja.getJSONObject(i);
                    MPregunta pre = new MPregunta();
                    MRespuesta res = new MRespuesta();
                    pre.setId_pre(jason.getInt("id_pre"));
                    pre.setId_estado(jason.getInt("id_estado"));
                    pre.setDes_pre(jason.getString("des_pre"));
                    pre.setFecha_pre(jason.getString("fecha_pre"));
                    res.setDes_res(jason.getString("des_res"));
                    res.setFecha_res(jason.getString("fecha_res"));
                    res.setId_cat(jason.getInt("id_cat"));
                    String fecha[] = jason.getString("fecha_nac").split("-");
                    pre.setEdad_usu(calcularEdad(Integer.valueOf(fecha[0]),Integer.valueOf(fecha[1]), Integer.valueOf(fecha[2])));
                    if(pre.getId_estado() == 2){
                        res.setCali_pro(promedioRes(jason.getInt("id_res")));
                    }
                    MPublicacion publi = new MPublicacion();
                    publi.setPregunta(pre);
                    publi.setRespuesta(res);
                    lista.add(publi);
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        System.out.println("lista tam" + lista.size());
        return lista;
    }
    
    public static MPregunta ConsultarPres(int id, String clave){
        MPregunta pre = new MPregunta();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("id_pre", id);
            String url = "/quetzual/pregunta/Consultar/Pregunta";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontrados")){
                JSONArray ja = jr.getJSONArray("datos");
                if(ja.length()>0){
                    JSONObject jso = ja.getJSONObject(0);
                    pre.setDes_pre(jso.getString("des_pre"));
                    pre.setId_pre(jso.getInt("id_pre"));
                    pre.setFecha_pre(jso.getString("Fecha_pre"));
                    pre.setId_usup(jso.getInt("id_usup"));
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        if(pre.getDes_pre() == null){
            pre.setDes_pre("no encontrada");
        }
        return pre;
    }
    
    // consultar respuestas
    
    public static List<MRespuesta> ConsultarRespuestas(int id, String clave){
        List<MRespuesta> lista = new ArrayList<MRespuesta>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("id_pre", id);
            String url = "/quetzual/respuesta/Consultar/Respuestas";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontrados")){
                JSONArray ja = jr.getJSONArray("datos");
                for(int i=0; i<ja.length(); i++){
                    // mrespuesta.id_res, mrespuesta.des_res, mrespuesta.fecha_res, musuario.nom_usu
                    JSONObject jso = ja.getJSONObject(i);
                    MRespuesta res = new MRespuesta();
                    res.setId_res(jso.getInt("id_res"));
                    res.setDes_res(jso.getString("des_res"));
                    res.setId_cat(jso.getInt("id_cat"));
                    res.setNom_doc(Cifrado.decrypt(jso.getString("nom_usu")));
                    res.setFecha_res(jso.getString("fecha_res"));
                    res.setId_usuRes(jso.getInt("id_usu"));
                    res.setCali_pro(promedioRes(res.getId_res()));
                    lista.add(res);
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return lista;
    }
    
    // preguntas similares
    
    public static List<MPregunta> PreguntasSimilares(String preg, String clave){
        List<MPregunta> lista = new ArrayList<MPregunta>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("pre", preg);
            String url = "/quetzual/pregunta/Similares";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontradas")){
                JSONArray ja = jr.getJSONArray("datos");
                for(int i=0; i<ja.length(); i++){
                    JSONObject jso= ja.getJSONObject(i);
                    MPregunta pre = consultarPre(jso.getInt("id_pre"));
                    pre.setDes_pre(jso.getString("des_pre"));
                    pre.setFecha_pre(jso.getString("fecha_pre"));
                    pre.setId_pre(jso.getInt("id_pre"));
                    String fecha[] = jso.getString("fecha_nac").split("-");
                    pre.setEdad_usu(calcularEdad(Integer.valueOf(fecha[0]),Integer.valueOf(fecha[1]), Integer.valueOf(fecha[2])));
                    lista.add(pre);
                }
                
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return lista;
    }
    
    public static boolean calificarres(int id, int res, int cal){
        boolean seguir = false;
        try{
            JSONObject jo = new JSONObject();
            jo.put("usu", id);
            jo.put("calif", cal);
            jo.put("resp", res);
            String url = "/quetzual/respuesta/Calificar/Respuesta/Usuario";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Eliminada")||status.equals("Calificada")){
                seguir = true;
            }
        }catch(Exception e){
            seguir = false;
            System.out.println(e.getMessage());
        }
        return seguir;
    }
    
    public static int caliRes(int id, int res, String clave){
        int total = 0;
        try{
            //{clave, usu, resp}
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("usu", id);
            jo.put("resp", res);
            String url = "/quetzual/respuesta/Calificada/Respuesta";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontrada")){
                total = jr.getInt("cal");
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            total = 0;
        }
        return total;
    }
    
    public static int calcularEdad(int ano, int mes, int dia){
        int edad = 0;
        try{
            Calendar fecha = java.util.Calendar.getInstance();
            int year  = fecha.get(java.util.Calendar.YEAR);
            int month = fecha.get(java.util.Calendar.MONTH);
            int day   = fecha.get(java.util.Calendar.DATE);
            int edad_base = year - ano;
            if (month < mes) edad_base--;
            else if (month == mes) {
                 if (day < dia) edad_base--;
            }
            edad = edad_base;
        }catch(Exception e){
            System.out.println( e.getMessage());
        }
        if(edad < 1){
            edad = 0;
        }
        return edad;
    }
    
    private static MPregunta consultarPre(int id){
        MPregunta pre = new MPregunta();
        try{
            JSONObject jo = new JSONObject();
            jo.put("id", id);
            String url = "/quetzual/respuesta/Cantidad/Respuesta";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontradas")){
                JSONArray ja = jr.getJSONArray("datos");
                pre.setCantidadRes(ja.length());
                JSONObject cat = ja.getJSONObject(0);
                pre.setId_catgen(cat.getInt("id_cat"));
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        if(pre.getDes_pre() == null){
            pre.setDes_pre("no encontrada");
        }
        return pre;
    }
    
    private static double promedioRes(int id){
        double prom = 0.0;
        try{
            JSONObject jo = new JSONObject();
            jo.put("id", id);
            String url = "/quetzual/respuesta/Promedio/Respuestas";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontradas")){
                JSONArray ja = jr.getJSONArray("datos");
                if(ja.length()>0){
                    double total = 0;
                
                    for(int i=0; i<ja.length(); i++){
                        JSONObject jso = ja.getJSONObject(i);
                        total += jso.getInt("cal");
                    }
                    prom = total/ja.length();
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return prom;
    }

}
