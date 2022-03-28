
package Modelo;

public class MUsuario implements Comparable<MUsuario>  {
    int id_usu, id_gen, id_rol, puntos, enc_usu, habilitada;
    String email, contra, fecha_nac, nom_usu, clave, token, mes;

    public MUsuario() {
    }

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
    }
    
    
    public int getId_usu() {
        return id_usu;
    }

    public void setId_usu(int id_usu) {
        this.id_usu = id_usu;
    }

    public int getId_gen() {
        return id_gen;
    }

    public void setId_gen(int id_gen) {
        this.id_gen = id_gen;
    }

    public int getId_rol() {
        return id_rol;
    }

    public void setId_rol(int id_rol) {
        this.id_rol = id_rol;
    }

    public int getPuntos() {
        return puntos;
    }

    public void setPuntos(int puntos) {
        this.puntos = puntos;
    }

    public int getEnc_usu() {
        return enc_usu;
    }

    public void setEnc_usu(int enc_usu) {
        this.enc_usu = enc_usu;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContra() {
        return contra;
    }

    public void setContra(String contra) {
        this.contra = contra;
    }

    public String getFecha_nac() {
        return fecha_nac;
    }

    public void setFecha_nac(String fecha_nac) {
        this.fecha_nac = fecha_nac;
    }

    public String getNom_usu() {
        return nom_usu;
    }

    public void setNom_usu(String nom_usu) {
        this.nom_usu = nom_usu;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getToken() {
        return token;
    }

    public int getHabilitada() {
        return habilitada;
    }

    public void setHabilitada(int habilitada) {
        this.habilitada = habilitada;
    }
    
    
    

    @Override
    public int compareTo(MUsuario o) {
        if (puntos < o.puntos) {
                return -1;
            }
            if (puntos > o.puntos) {
                return 1;
            }
            return 0;
    }
    
}
