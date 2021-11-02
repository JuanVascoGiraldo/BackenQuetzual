
package Control;

    import java.security.*;
    import javax.crypto.*;
    import javax.crypto.spec.SecretKeySpec;

    import sun.misc.*;

public class Cifrado {
    private static final String clave = "S~J?xm,:c7WU8HFz)K$a$N&[V:ez*EN#";
    private static final byte[] keyvalue = clave.getBytes() ;
    
    private static final String instancia = "AES";
    
    public static String encrypt(String Data) throws Exception {
        Key key = generateKey();
        Cipher cifrado = Cipher.getInstance(instancia);
        cifrado.init(Cipher.ENCRYPT_MODE, key);
        byte[] encValores = cifrado.doFinal(Data.getBytes());
        String valoresencriptados = new BASE64Encoder().encode(encValores);
        return valoresencriptados;
    }
    public static String decrypt(String valoresencriptados) throws Exception {
        Key key = generateKey();
        Cipher cifrado = Cipher.getInstance(instancia);
        cifrado.init(Cipher.DECRYPT_MODE, key);
        byte [] decodificadorvalores = new BASE64Decoder().decodeBuffer(valoresencriptados);
        byte[] decValores = cifrado.doFinal(decodificadorvalores);
        String valoresdescifrados = new String(decValores);
        return valoresdescifrados;
    }
    private static Key generateKey() throws Exception {
        Key key = new SecretKeySpec(keyvalue, instancia);
        return key;
    }
}
