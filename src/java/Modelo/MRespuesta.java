
package Modelo;

public class MRespuesta {
    int id_res, id_pre, id_cat, id_usuRes; 
    double cali_pro;
    String des_res, fecha_res, des_cat, nom_doc;

    public MRespuesta() {
    }

    public int getId_res() {
        return id_res;
    }

    public void setId_res(int id_res) {
        this.id_res = id_res;
    }

    public int getId_pre() {
        return id_pre;
    }

    public void setId_pre(int id_pre) {
        this.id_pre = id_pre;
    }

    public int getId_cat() {
        return id_cat;
    }

    public void setId_cat(int id_cat) {
        this.id_cat = id_cat;
    }

    public int getId_usuRes() {
        return id_usuRes;
    }

    public void setId_usuRes(int id_usuRes) {
        this.id_usuRes = id_usuRes;
    }

    public void setCali_pro(double cali_pro) {
        this.cali_pro = cali_pro;
    }

    public double getCali_pro() {
        return cali_pro;
    }

    

    public String getDes_res() {
        return des_res;
    }

    public void setDes_res(String des_res) {
        this.des_res = des_res;
    }

    public String getFecha_res() {
        return fecha_res;
    }

    public void setFecha_res(String fecha_res) {
        this.fecha_res = fecha_res;
    }

    public String getDes_cat() {
        return des_cat;
    }

    public void setDes_cat(String des_cat) {
        this.des_cat = des_cat;
    }

    public String getNom_doc() {
        return nom_doc;
    }

    public void setNom_doc(String nom_doc) {
        this.nom_doc = nom_doc;
    }
    
}
