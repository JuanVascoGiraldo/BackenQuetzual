
package Control;

import Modelo.MUsuario;
import Modelo.CCategoria;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

public class GestionarUsuario {
    private static final String claveusu = "As7cnuLSSGkw85A8SdrDJmqLHsSJAfqd";
    private static final String clavedoc = "S:sVw>SN?j75zcA#-q{YdZ_5#W{E=X2q";
    private static final String claveadmin = "72eV)'xL9}:NQ999X(MUFa$MTw]$zz;w";
    
    public static boolean CrearUsuario(MUsuario usu){
        boolean funciono = true;
        try{
            JSONObject jo = new JSONObject();
            jo.put("Nombre", Cifrado.encrypt(usu.getNom_usu()));
            jo.put("correo", Cifrado.encrypt(usu.getEmail()));
            jo.put("contra", Cifrado.encrypt(usu.getContra()));
            jo.put("fecha", usu.getFecha_nac());
            jo.put("genero",usu.getId_gen());
            jo.put("Clave", "As7cnuLSSGkw85A8SdrDJmqLHsSJAfqd");
            jo.put("enviar", usu.getEmail());
            String url = "/quetzual/usuario/Registrar/Token";
            JSONObject js = ConexionAPI.peticionPostJSONObject(url, jo);
            String estatus = js.getString("status");
            if(estatus.equals("Enviado")){
                funciono = true;
            }else{
                funciono = false;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            funciono = false;
        }
        return funciono;
    }
    
    public static List<String> ConfirmarUsuario(String token){
        List<String> respuesta = new ArrayList<String>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("status", "enviado");
            String url = "/quetzual/usuario/Registrar/Usuario/Estudiante";
            JSONObject js = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
            String estatus = js.getString("status");
            if(estatus.equals("Se ha guardado el Usuario")){
                respuesta.add(0, "registrado");
                respuesta.add(1, js.getString("Correo"));
                respuesta.add(2, js.getString("Contra"));
            }else{
                respuesta.add(0, "error");
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            respuesta.add(0, "error");
        }
        return respuesta;
    }
    
    public static boolean CrearDoctor(MUsuario usu, MUsuario us){
        boolean funciono = true;
        try{
            JSONObject jo = new JSONObject();
            jo.put("Nombre", Cifrado.encrypt(usu.getNom_usu()));
            jo.put("correo", Cifrado.encrypt(usu.getEmail()));
            jo.put("contra", Cifrado.encrypt(usu.getContra()));
            jo.put("fecha", usu.getFecha_nac());
            jo.put("genero",usu.getId_gen());
            jo.put("Clave", us.getClave());
            jo.put("id", us.getId_usu());
            String url = "/quetzual/usuario/Registrar/Usuario/Doctor";
            JSONObject js = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, us.getToken());
            String estatus = js.getString("status");
            if(estatus.equals("Se ha guardado el Usuario")){
                funciono = true;
            }else{
                funciono = false;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            funciono = false;
        }
        return funciono;
    }
    
    public static MUsuario iniciarSesion(String email, String pass){
        MUsuario usu = new MUsuario();
        try{
            JSONObject jo = new JSONObject();
            jo.put("correo", Cifrado.encrypt(email));
            jo.put("contra", Cifrado.encrypt(pass));
            String url = "/quetzual/usuario/Iniciar/Sesion/Validar";
            JSONObject js = ConexionAPI.peticionPostJSONObject(url, jo);
            String estatus = js.getString("status");
            if(estatus.equals("Se ha iniciado Sesion")){
                JSONArray ja = js.getJSONArray("usuario");
                JSONObject usuario = ja.getJSONObject(0);
                usu.setId_rol(usuario.getInt("id_rol"));
                usu.setContra(Cifrado.decrypt(usuario.getString("contra_usu")));
                usu.setEmail(Cifrado.decrypt(usuario.getString("email_usu")));
                usu.setFecha_nac(usuario.getString("fecha_nac"));
                usu.setId_usu(usuario.getInt("id_usu"));
                usu.setNom_usu(Cifrado.decrypt(usuario.getString("nom_usu")));
                usu.setId_gen(usuario.getInt("id_gen"));
                usu.setToken(js.getString("token"));
            }else{
                usu.setNom_usu("No se ha encontrado ningun usuario");
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            usu.setNom_usu("No se ha encontrado ningun usuario");
        }
        return usu;
    }
    
    public static boolean ModificarUsuario(MUsuario usu){
        boolean cambio = false;
        try{
            JSONObject jo = new JSONObject();
            jo.put("id", usu.getId_usu());
            jo.put("fecha",usu.getFecha_nac() );
            jo.put("nombre",Cifrado.encrypt(usu.getNom_usu()));
            jo.put("id_gen", usu.getId_gen());
            jo.put("rol",usu.getId_rol() );
            jo.put("clave", usu.getClave());
            String url = "/quetzual/usuario/Modificar/Usuario";
            JSONObject js = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, usu.getToken());
            String estatus = js.getString("status");
            if(estatus.equals("Cambio Guardado")){
                cambio = true;
            }else{
                cambio = false;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            cambio = false;
        }
        return cambio;
    }
    
    public static boolean ModificarUsuarioDoctor(MUsuario usu){
        boolean cambio = false;
        try{
            JSONObject jo = new JSONObject();
            jo.put("id", usu.getId_usu());
            jo.put("correo", Cifrado.encrypt(usu.getEmail()));
            jo.put("fecha",usu.getFecha_nac() );
            jo.put("nombre",Cifrado.encrypt(usu.getNom_usu()));
            jo.put("id_gen", usu.getId_gen());
            jo.put("rol",usu.getId_rol() );
            jo.put("clave", usu.getClave());
            String url = "/quetzual/usuario/Modificar/Usuario/Doctor";
            JSONObject js = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, usu.getToken());
            String estatus = js.getString("status");
            if(estatus.equals("Cambio Guardado")){
                cambio = true;
            }else{
                cambio = false;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            cambio = false;
        }
        return cambio;
    }
    
    public static boolean ModificarContra(String contra, int id, int rol, String clave, String token){
        boolean cambio = false;
        try{
            JSONObject jo = new JSONObject();
            jo.put("id",id);
            jo.put("pass",Cifrado.encrypt(contra));
            jo.put("rol",rol);
            jo.put("clave", clave);
            String url = "/quetzual/usuario/Modificar/Password";
            JSONObject js = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
            String estatus = js.getString("status");
            if(estatus.equals("Cambio Realizado")){
                cambio = true;
            }else{
                cambio = false;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            cambio = false;
        }
        return cambio;
    }
    
    public static List<MUsuario> BuscarDoctores(String clave, String token){
       List<MUsuario> docs = new ArrayList<MUsuario>();
       try{
           JSONObject jo = new JSONObject();
           jo.put("clave", clave);
           String url = "/quetzual/usuario/Obtener/Doctores";
           JSONObject jr = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
           String status = jr.getString("status");
           if(status.equals("Encontrados")){
               JSONArray ja  = jr.getJSONArray("datos");
               for(int i=0; i<ja.length(); i++){
                   JSONObject doc = ja.getJSONObject(i);
                   MUsuario usu = new MUsuario();
                   usu.setEmail(Cifrado.decrypt(doc.getString("email_usu")));
                   usu.setFecha_nac(doc.getString("fecha_nac"));
                   usu.setId_gen(doc.getInt("id_gen"));
                   usu.setNom_usu(Cifrado.decrypt(doc.getString("nom_usu")));
                   usu.setId_usu(doc.getInt("id_usu"));
                   docs.add(usu);
               }
           }
       }catch(Exception e){
            System.out.println(e.getMessage());
        }
       return docs;
    }
    
    public static List<MUsuario> BuscarDoctoresrank(String clave, String token){
       List<MUsuario> docs = new ArrayList<MUsuario>();
       try{
           JSONObject jo = new JSONObject();
           jo.put("clave", clave);
           String url = "/quetzual/usuario/Obtener/Doctores/rank";
           JSONObject jr = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
           String status = jr.getString("status");
           if(status.equals("Encontrados")){
               JSONArray ja  = jr.getJSONArray("datos");
               for(int i=0; i<ja.length(); i++){
                   JSONObject doc = ja.getJSONObject(i);
                   MUsuario usu = new MUsuario();
                   usu.setNom_usu(Cifrado.decrypt(doc.getString("nom_usu")));
                   usu.setId_usu(doc.getInt("id_usu"));
                   docs.add(usu);
               }
           }
       }catch(Exception e){
            System.out.println(e.getMessage());
        }
       return docs;
    }
    
    public static List<MUsuario> ObtenerRankingMensual(String mes, String clave){
        List<MUsuario> docs = new ArrayList<MUsuario>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("mes", mes);
            jo.put("clave", clave);
            String url = "/quetzual/usuario/Ranking/Mensual";
            JSONObject js = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = js.getString("status");
            if(status.equals("Encontradas")){
                JSONArray ja = js.getJSONArray("datos");
                for(int i=0; i<ja.length(); i++){
                    JSONObject doc = ja.getJSONObject(i);
                    MUsuario usu = new MUsuario();
                    usu.setNom_usu(Cifrado.decrypt(doc.getString("nom_usu")));
                    usu.setPuntos(doc.getInt("cant_punt"));
                    docs.add(usu);
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return docs;
    }
    
    public static ArrayList<MUsuario> ObtenerRankingHistorico(String Clave, String token){
        ArrayList<MUsuario> docs = new ArrayList<MUsuario>();
        try{
            List<MUsuario> usua = BuscarDoctoresrank(Clave, token);
            String url = "/quetzual/usuario/Ranking/Historico";
            for(MUsuario u:usua){
                JSONObject jo = new JSONObject();
                jo.put("clave", Clave);
                jo.put("id", u.getId_usu());
                JSONObject ja = ConexionAPI.peticionPostJSONObject(url, jo);
                String status = ja.getString("status");
                MUsuario usu = new MUsuario();
                if(status.equals("Datos")){
                  usu.setPuntos(ja.getInt("total"));
                  usu.setNom_usu(u.getNom_usu());
                  docs.add(usu);
                }else{
                    usu.setPuntos(0);
                    usu.setNom_usu(u.getNom_usu());
                    docs.add(usu);
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        Collections.sort(docs,  new Comparator<MUsuario>() {
                        @Override
                        public int compare(MUsuario d1, MUsuario d2) {
                                return new Integer(d2.getPuntos()).compareTo(new Integer(d1.getPuntos()));
                        }
                });
        return docs;
    }
    
    public static boolean EliminarUsuario(int id, int rol, String clave, String token){
        boolean cambio = false;
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("id", id);
            jo.put("rol", rol);
            String url = "/quetzual/usuario/Eliminar/Estudiante";
            JSONObject jr = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
            String status = jr.getString("status");
            if(status.equals("Cuenta Eliminada")){
                cambio = true;
            }
        }catch(Exception e){
            cambio = false;
            System.out.println(e.getMessage());
        }
        return cambio;
    }
    
    public static boolean DeshabilitarDoctor(int id, String token){
        boolean cambio = false;
        try{
            JSONObject jo = new JSONObject();
            jo.put("id", id);
            String url = "/quetzual/usuario/Deshabilitar/Doctor";
            JSONObject jr = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
            String status = jr.getString("status");
            if(status.equals("Cuenta Deshabilitada")){
                cambio = true;
            }
        }catch(Exception e){
            cambio = false;
            System.out.println(e.getMessage());
        }
        return cambio;
    }
    
    public static List<CCategoria> ProgresoGenerar(String clave){
        List<CCategoria> categorias = new ArrayList<CCategoria>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            String url = "/quetzual/usuario/Progreso/General";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Encontrados")){
                JSONArray ja = jr.getJSONArray("datos");
                List<Integer> listcat1 = new ArrayList<Integer>();
                List<Integer> listcat2 = new ArrayList<Integer>();
                List<Integer> listcat3 = new ArrayList<Integer>();
                List<Integer> listcat4 = new ArrayList<Integer>();
                List<Integer> listcat5 = new ArrayList<Integer>();
                for(int i =0 ; i<ja.length(); i++){
                    JSONObject cat = ja.getJSONObject(i);
                    if(cat.getInt("id_cat") == 1){
                        listcat1.add(cat.getInt("cal"));
                    }else if(cat.getInt("id_cat") == 2){
                        listcat2.add(cat.getInt("cal"));
                    }else if(cat.getInt("id_cat") == 3){
                        listcat3.add(cat.getInt("cal"));
                    }else if(cat.getInt("id_cat") == 4){
                        listcat4.add(cat.getInt("cal"));
                    }else if(cat.getInt("id_cat") == 5){
                        listcat5.add(cat.getInt("cal"));
                    }
                }
                CCategoria cat1 = new CCategoria();
                cat1.setId_cat(1);
                int puntos1= 0;
                for(int i = 0; i<listcat1.size(); i++){
                    puntos1 += listcat1.get(i);
                }
                double size1 = 1.0;
                if(listcat1.size() !=0)size1 = Double.valueOf(listcat1.size());
                cat1.setPuntos(Double.valueOf(puntos1)/size1);
                
                CCategoria cat2 = new CCategoria();
                cat2.setId_cat(2);
                int puntos2= 0;
                for(int i = 0; i<listcat2.size(); i++){
                    puntos2 += listcat2.get(i);
                }
                
                double size2 = 1.0;
                if(listcat2.size() !=0)size2 = Double.valueOf(listcat2.size());
                cat2.setPuntos(Double.valueOf(puntos2)/size2);
                
                CCategoria cat3 = new CCategoria();
                cat3.setId_cat(3);
                int puntos3= 0;
                for(int i = 0; i<listcat3.size(); i++){
                    puntos3 += listcat3.get(i);
                }
                double size3 = 1.0;
                if(listcat3.size() !=0)size3 = Double.valueOf(listcat3.size());
                cat3.setPuntos(Double.valueOf(puntos3)/size3);
                
                CCategoria cat4 = new CCategoria();
                cat4.setId_cat(4);
                int puntos4= 0;
                for(int i = 0; i<listcat4.size(); i++){
                    puntos4 += listcat4.get(i);
                }
                double size4 = 1.0;
                if(listcat4.size() !=0)size4 = Double.valueOf(listcat4.size());
                cat4.setPuntos(Double.valueOf(puntos4)/size4);
                
                CCategoria cat5 = new CCategoria();
                cat5.setId_cat(5);
                int puntos5= 0;
                for(int i = 0; i<listcat5.size(); i++){
                    puntos5 += listcat5.get(i);
                }
                double size5 = 1.0;
                if(listcat5.size() !=0)size5 = Double.valueOf(listcat5.size());
                cat5.setPuntos(Double.valueOf(puntos5)/size5);
                
                cat1.setDes_cat("ETS");
                cat2.setDes_cat("Embarazo");
                cat3.setDes_cat("Salud sexual femenina");
                cat4.setDes_cat("Salud sexual masculina");
                cat5.setDes_cat("Anticonceptivos");
                
                categorias.add(cat1);
                categorias.add(cat2);
                categorias.add(cat3);
                categorias.add(cat4);
                categorias.add(cat5);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        if(categorias.size() == 0){
            CCategoria cat1 = new CCategoria();
            CCategoria cat2 = new CCategoria();
            CCategoria cat3 = new CCategoria();
            CCategoria cat4 = new CCategoria();
            CCategoria cat5 = new CCategoria();
            cat1.setDes_cat("ETS");
            cat2.setDes_cat("Embarazo");
            cat3.setDes_cat("Salud sexual femenina");
            cat4.setDes_cat("Salud sexual masculina");
            cat5.setDes_cat("Anticonceptivos");
            cat1.setPuntos(0.0);
            cat2.setPuntos(0.0);
            cat3.setPuntos(0.0);
            cat4.setPuntos(0.0);
            cat5.setPuntos(0.0);
            categorias.add(cat1);
            categorias.add(cat2);
            categorias.add(cat3);
            categorias.add(cat4);
            categorias.add(cat5);
        }
        
        return categorias;
    }
    
    public static List<CCategoria> ProgresoUSuario(int id, String clave, String token){
        List<CCategoria> categorias = new ArrayList<CCategoria>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("id", id);
            String url = "/quetzual/usuario/Progreso/Usuario/Calificaciones";
            JSONObject jr = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
            String status = jr.getString("status");
            if(status.equals("Encontrados")){
                JSONArray ja = jr.getJSONArray("datos");
                List<Integer> listcat1 = new ArrayList<Integer>();
                List<Integer> listcat2 = new ArrayList<Integer>();
                List<Integer> listcat3 = new ArrayList<Integer>();
                List<Integer> listcat4 = new ArrayList<Integer>();
                List<Integer> listcat5 = new ArrayList<Integer>();
                for(int i =0 ; i<ja.length(); i++){
                    JSONObject cat = ja.getJSONObject(i);
                    if(cat.getInt("id_cat") == 1){
                        listcat1.add(cat.getInt("cal"));
                    }else if(cat.getInt("id_cat") == 2){
                        listcat2.add(cat.getInt("cal"));
                    }else if(cat.getInt("id_cat") == 3){
                        listcat3.add(cat.getInt("cal"));
                    }else if(cat.getInt("id_cat") == 4){
                        listcat4.add(cat.getInt("cal"));
                    }else if(cat.getInt("id_cat") == 5){
                        listcat5.add(cat.getInt("cal"));
                    }
                }
                CCategoria cat1 = new CCategoria();
                cat1.setId_cat(1);
                int puntos1= 0;
                for(int i = 0; i<listcat1.size(); i++){
                    puntos1 += listcat1.get(i);
                }
                double size1 = 1.0;
                if(listcat1.size() !=0)size1 = Double.valueOf(listcat1.size());
                cat1.setPuntos(Double.valueOf(puntos1)/size1);
                
                
                CCategoria cat2 = new CCategoria();
                cat2.setId_cat(2);
                int puntos2= 0;
                for(int i = 0; i<listcat2.size(); i++){
                    puntos2 += listcat2.get(i);
                }
                double size2 = 1.0;
                if(listcat2.size() !=0)size2 = Double.valueOf(listcat2.size());
                cat2.setPuntos(Double.valueOf(puntos2)/size2);
                
                CCategoria cat3 = new CCategoria();
                cat3.setId_cat(3);
                int puntos3= 0;
                for(int i = 0; i<listcat3.size(); i++){
                    puntos3 += listcat3.get(i);
                }
                double size3 = 1.0;
                if(listcat3.size() !=0)size3 = Double.valueOf(listcat3.size());
                cat3.setPuntos(Double.valueOf(puntos3)/size3);
                
                CCategoria cat4 = new CCategoria();
                cat4.setId_cat(4);
                int puntos4= 0;
                for(int i = 0; i<listcat4.size(); i++){
                    puntos4 += listcat4.get(i);
                }
                double size4 = 1.0;
                if(listcat4.size() !=0)size4 = Double.valueOf(listcat4.size());
                cat4.setPuntos(Double.valueOf(puntos4)/size4);
                
                CCategoria cat5 = new CCategoria();
                cat5.setId_cat(5);
                int puntos5= 0;
                for(int i = 0; i<listcat5.size(); i++){
                    puntos5 += listcat5.get(i);
                }
                double size5 = 1.0;
                if(listcat5.size() !=0)size5 = Double.valueOf(listcat5.size());
                cat5.setPuntos(Double.valueOf(puntos5)/size5);
                
                cat1.setDes_cat("ETS");
                cat2.setDes_cat("Embarazo");
                cat3.setDes_cat("Salud sexual femenina");
                cat4.setDes_cat("Salud sexual masculina");
                cat5.setDes_cat("Anticonceptivos");
                
                categorias.add(cat1);
                categorias.add(cat2);
                categorias.add(cat3);
                categorias.add(cat4);
                categorias.add(cat5);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        if(categorias.size() == 0){
            CCategoria cat1 = new CCategoria();
            CCategoria cat2 = new CCategoria();
            CCategoria cat3 = new CCategoria();
            CCategoria cat4 = new CCategoria();
            CCategoria cat5 = new CCategoria();
            cat1.setDes_cat("ETS");
            cat2.setDes_cat("Embarazo");
            cat3.setDes_cat("Salud sexual femenina");
            cat4.setDes_cat("Salud sexual masculina");
            cat5.setDes_cat("Anticonceptivos");
            cat1.setPuntos(0.0);
            cat2.setPuntos(0.0);
            cat3.setPuntos(0.0);
            cat4.setPuntos(0.0);
            cat5.setPuntos(0.0);
            categorias.add(cat1);
            categorias.add(cat2);
            categorias.add(cat3);
            categorias.add(cat4);
            categorias.add(cat5);
        }
        return categorias;
    }
    
    public static List<Integer> ProgresoPreguntas(int id, String clave, String token){
        List<Integer> preguntas = new ArrayList<Integer>();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("id", id);
            String url = "/quetzual/usuario/Progreso/Estudiante/Preguntas";
            JSONObject jr = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
            String status = jr.getString("status");
            if(status.equals("Preguntas encontradas")){
                int respondidas = jr.getInt("respondidas");
                int rechazadas = jr.getInt("rechazadas");
                preguntas.add(respondidas);
                preguntas.add(rechazadas);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        if(preguntas.size() == 0){
            preguntas.add(0);
            preguntas.add(0);
        }
        return preguntas;
    }
    
    public static MUsuario consultarDoctor(int id, String clave, String token){
        MUsuario usu = new MUsuario();
        try{
            JSONObject jo = new JSONObject();
            jo.put("clave", clave);
            jo.put("id", id);
            String url = "/quetzual/usuario/Consultar/Doctor";
            JSONObject jr = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
            String status = jr.getString("status");
            if(status.equals("Encontradas")){
                JSONArray ja = jr.getJSONArray("datos");
                if(ja.length()>0){
                    JSONObject json = ja.getJSONObject(0);
                    usu.setId_gen(json.getInt("id_gen"));
                    usu.setNom_usu(Cifrado.decrypt(json.getString("nom_usu")));
                    usu.setFecha_nac(json.getString("fecha_nac"));
                    usu.setEmail(Cifrado.decrypt(json.getString("email_usu")));
                }
            }else{
                usu.setNom_usu("no encontrado");
            }
        }catch(Exception e){
            usu.setNom_usu("no encontrado");
        }
        if(usu.getNom_usu()==null){
            usu.setNom_usu("no encontrado");
        }
        return usu;
    }
    
    public static boolean GenerarTokenPass(String correo){
        boolean seguir = false;
        try{
            JSONObject jo = new JSONObject();
            //email, sendemail
            jo.put("email", Cifrado.encrypt(correo));
            jo.put("sendemail", correo);
            String url = "/quetzual/usuario/Recuperar/Password/Token";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Enviado")){
                seguir = true;
            }else{
                seguir = false;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            seguir = false;
        }
        return seguir;
    }
    
    public static boolean ComprobarTokenPass(String token){
        boolean seguir = false;
        try{
            JSONObject jo = new JSONObject();
            jo.put("token", token);
            String url = "/quetzual/usuario/Vericar/Token/Pass";
            JSONObject jr = ConexionAPI.peticionPostJSONObject(url, jo);
            String status = jr.getString("status");
            if(status.equals("Valido")){
                seguir = true;
            }else{
                seguir = false;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            seguir = false;
        }
        return seguir;
    }
    
    public static boolean RecupearPass(String token, String pass){
        boolean seguir = false;
        try{
            JSONObject jo = new JSONObject();
            jo.put("pass", pass);
            String url = "/quetzual/usuario/Recuperar/Password";
            JSONObject jr = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
            String status = jr.getString("status");
            if(status.equals("Cambio Guardado")){
                seguir = true;
            }else{
                seguir = false;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            seguir = false;
        }
        return seguir;
    }
    
    public static boolean GenerarTokenEmail(MUsuario usu, String email){
        boolean seguir = false;
        try{
            JSONObject jo = new JSONObject();
            jo.put("email", email);
            jo.put("newemail", Cifrado.encrypt(email));
            jo.put("id", usu.getId_usu());
            jo.put("clave", usu.getClave());
            String url = "/quetzual/usuario/Cambiar/Email";
            JSONObject jr = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, usu.getToken());
            String status = jr.getString("status");
            if(status.equals("Enviado")){
                seguir = true;
            }else{
                seguir = false;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            seguir = false;
        }
        return seguir;
    }
    
    public static boolean ConfirmarCorreo(String token){
        boolean funciono = true;
        try{
            JSONObject jo = new JSONObject();
            jo.put("status", "enviado");
            String url = "/quetzual/usuario/Confirmar/Email";
            JSONObject js = ConexionAPI.peticionPostJSONObjectcontoken(url, jo, token);
            String estatus = js.getString("status");
            if(estatus.equals("Cambio Guardado")){
                funciono = true;
            }else{
                funciono = false;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            funciono = false;
        }
        return funciono;
    }
    
    
    
    
}
