
package Control;

import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validar {
   
    //private static final String ExpCorreo = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
    private static final String ExpCorreo = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$";
    private static final String Expnombre = "^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð]+$";
    private static final String ExpFecha = "^(\\d{4})(\\/|-)(\\d{1,2})(\\/|-)(\\d{1,2})$";
    private static final String ExpContra = "^(?=\\w*\\d)(?=\\w*[A-Z])(?=\\w*[a-z])\\S{8,16}$";
    private static final String ExpPregunta = "^[a-zA-Z0-9àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑ \\? \\¿,\\.]+$";
    private static final String ExpFechapre = "^(?:3[01]|[12][0-9]|0?[1-9])([\\-/.])(0?[1-9]|1[1-2])\\1\\d{4}$";
    private static final String ExpGenero = "^[123]$";
    private static final String ExpFiltro = "^[0-9]$";
    
    public static boolean Validarcorreo(String correo){
        Pattern pattern = Pattern.compile(ExpCorreo);
        Matcher matcher = pattern.matcher(correo);
        if(matcher.matches()){
           if(correo.length() > 40 || correo.length() < 10){
               System.out.println("Tamaño del coreeo no valido");
               return false;
           }else{
               return true;
           }
        }else{
            System.out.println("Correo no valido");
            return false;
        }
      }
    public static boolean Validarcontra(String contra){
        Pattern pattern = Pattern.compile(ExpContra);
        Matcher matcher = pattern.matcher(contra);
        return matcher.matches();
      }
    public static boolean Validarfecha(String fecha){
        boolean seguir = false;
        Pattern pattern = Pattern.compile(ExpFecha);
        Matcher matcher = pattern.matcher(fecha);
        if(matcher.matches()){
            Calendar fechas = java.util.Calendar.getInstance();
            int year  = fechas.get(java.util.Calendar.YEAR);
            String[] valores = fecha.split("-");
            int yearnaci = Integer.valueOf(valores[0]);
            int difyear = year - yearnaci;
            if(difyear>10 && difyear<100){
                return true;
            }
        }
        return seguir;
      }
    
    public static boolean ValidarfechaPre(String fecha){
        Pattern pattern = Pattern.compile(ExpFechapre);
        Matcher matcher = pattern.matcher(fecha);
        return matcher.matches();
      }

    public static boolean Validarnombre(String nombre){
        Pattern pattern = Pattern.compile(Expnombre);
        Matcher matcher = pattern.matcher(nombre);
        if(matcher.matches()){
           if(nombre.length() > 20 || nombre.length() == 0){
               return false;
           }else{
               return true;
               
           }
        }else{
            return false;
        }
      }
    public static boolean Validarpregunta(String pregunta){
        Pattern pattern = Pattern.compile(ExpPregunta);
        Matcher matcher = pattern.matcher(pregunta);
        if(matcher.matches()){
           if(pregunta.length() > 200 || pregunta.length() < 11){
               return false;
           }else{
               return true;
           }
        }else{
            return false;
        }
      }
    
    public static boolean ValidarGenero(String genero){
        Pattern pattern = Pattern.compile(ExpGenero);
        Matcher matcher = pattern.matcher(genero);
        if(matcher.matches()){
            if(genero.length() > 1){
               return false;
           }else{
               return true;
           }
        }else{
            return false;
        }
    }
    
    public static boolean ValidarFiltro(String filtro){
        Pattern pattern = Pattern.compile(ExpFiltro);
        Matcher matcher = pattern.matcher(filtro);
        if(matcher.matches()){
               return true;
        }else{
            return false;
        }
    }
}
