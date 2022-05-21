
package Control;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import org.json.JSONArray;
import org.json.JSONObject;

public class ConexionAPI {
   public static final String url = "http://137.184.233.135:4000";
    // public static final String url = "http://localhost:4000";
    
    public static JSONObject peticionPostJSONObject(String urll, JSONObject data)throws Exception{
        String charset = "UTF-8"; 
        StringBuilder resultado = new StringBuilder();
        URLConnection connection = new URL(url + urll).openConnection();
        connection.setDoOutput(true); // Triggers POST.
        connection.setRequestProperty("Accept-Charset", charset);
        connection.setRequestProperty("Content-Type", "application/json;charset=" + charset);
        try (OutputStream output = connection.getOutputStream()) {
          output.write(data.toString().getBytes(charset));
        }
        BufferedReader rd = new BufferedReader(new InputStreamReader (connection.getInputStream()));
        String linea;
        while ((linea = rd.readLine()) != null) {
                resultado.append(linea);
        }
        rd.close();
        
        return new JSONObject(resultado.toString());
    }
    
    public static JSONObject peticionPostJSONObjectcontoken(String urll, JSONObject data, String token)throws Exception{
        String charset = "UTF-8"; 
        StringBuilder resultado = new StringBuilder();
        URLConnection connection = new URL(url + urll).openConnection();
        connection.setDoOutput(true); // Triggers POST.
        connection.setRequestProperty("Accept-Charset", charset);
        connection.setRequestProperty("token", token);
        connection.setRequestProperty("Content-Type", "application/json;charset=" + charset);
        try (OutputStream output = connection.getOutputStream()) {
          output.write(data.toString().getBytes(charset));
        }
        BufferedReader rd = new BufferedReader(new InputStreamReader (connection.getInputStream()));
        String linea;
        while ((linea = rd.readLine()) != null) {
                resultado.append(linea);
        }
        rd.close();
        
        return new JSONObject(resultado.toString());
    }
}
