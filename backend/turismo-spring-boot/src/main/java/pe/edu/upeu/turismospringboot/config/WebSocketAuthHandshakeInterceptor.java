package pe.edu.upeu.turismospringboot.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;
import pe.edu.upeu.turismospringboot.repository.UsuarioRepository;
import pe.edu.upeu.turismospringboot.service.auth.JwtService;

import java.util.Map;

@Component
public class WebSocketAuthHandshakeInterceptor implements HandshakeInterceptor {

    @Autowired
    private JwtService jwtService;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) {

        if (request instanceof ServletServerHttpRequest servletRequest) {
            String token = servletRequest.getServletRequest().getParameter("token");

            if (token != null && jwtService.isTokenValid(token)) {
                String username = jwtService.getUsernameFromToken(token);

                // Verificar que el usuario realmente exista en BD
                return usuarioRepository.findByUsername(username).map(usuario -> {
                    attributes.put("usuarioId", usuario.getIdUsuario());
                    return true;
                }).orElse(false); // Usuario no encontrado
            }
        }

        return false; // Token inválido o no presente
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
                               WebSocketHandler wsHandler, Exception exception) {
        // No es necesario implementar
    }
}