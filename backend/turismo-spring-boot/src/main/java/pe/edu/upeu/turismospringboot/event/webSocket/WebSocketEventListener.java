package pe.edu.upeu.turismospringboot.event.webSocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import pe.edu.upeu.turismospringboot.repository.UsuarioRepository;

import java.time.LocalDateTime;

@Component
public class WebSocketEventListener {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @EventListener
    public void handleDisconnect(SessionDisconnectEvent event) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(event.getMessage());
        String username = accessor.getUser() != null ? accessor.getUser().getName() : null;
        if (username != null) {
            usuarioRepository.findByUsername(username).ifPresent(usuario -> {
                usuario.setUltimaConexion(LocalDateTime.now());
                usuarioRepository.save(usuario);
            });
        }
    }
}