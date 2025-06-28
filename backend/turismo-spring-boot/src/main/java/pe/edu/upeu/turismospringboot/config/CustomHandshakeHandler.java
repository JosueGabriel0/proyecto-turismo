package pe.edu.upeu.turismospringboot.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.DefaultHandshakeHandler;
import pe.edu.upeu.turismospringboot.service.auth.JwtService;

import java.security.Principal;
import java.util.Map;

@Component
public class CustomHandshakeHandler extends DefaultHandshakeHandler {

    @Autowired
    private JwtService jwtService;

    @Override
    protected Principal determineUser(ServerHttpRequest request,
                                      WebSocketHandler wsHandler,
                                      Map<String, Object> attributes) {

        if (request instanceof ServletServerHttpRequest servletRequest) {
            String token = servletRequest.getServletRequest().getParameter("token");
            if (token != null && jwtService.isTokenValid(token)) {
                String username = jwtService.getUsernameFromToken(token);
                System.out.println("Handshake exitoso. Usuario: " + username);
                return () -> username; // Se crea un Principal usando lambda
            }
            System.out.println("Token inválido o ausente en handshake.");
        }
        return null;
    }
}