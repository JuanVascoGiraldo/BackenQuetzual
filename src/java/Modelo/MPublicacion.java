
package Modelo;
public class MPublicacion {
    MRespuesta respuesta;
    MPregunta pregunta;

    public MPublicacion() {
    }

    public MRespuesta getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(MRespuesta respuesta) {
        this.respuesta = respuesta;
    }

    public MPregunta getPregunta() {
        return pregunta;
    }

    public void setPregunta(MPregunta pregunta) {
        this.pregunta = pregunta;
    }
    
}
