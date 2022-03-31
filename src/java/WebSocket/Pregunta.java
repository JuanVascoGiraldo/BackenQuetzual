
package WebSocket;

import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/Pregunta")
public class Pregunta {

    private static Set<Session> sessions = new CopyOnWriteArraySet<>();
    
    @OnOpen
    public void open(Session session) {
        System.out.println("Session opened ==>");
        System.out.println(session.getBasicRemote());
        sessions.add(session);
        System.out.println(sessions.size());
    }
    
    @OnMessage
    public void onMessage(String message) {
        try{
            for (Session s : sessions) {
                synchronized (s){
                        s.getBasicRemote().sendText(message);
                }
                    }
        }catch(Exception e){
            System.out.println(e.getMessage());
        
        }
        
    }
    
    @OnClose
    public void close(Session session) {
        System.out.println("Session closed ==>");
        sessions.remove(session);
    }
    
    @OnError
    public void onError(Throwable e) {
        System.out.println(e.getMessage());
        e.printStackTrace();
    }
    
}
