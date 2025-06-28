package pe.edu.upeu.turismospringboot.controller.webSocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import pe.edu.upeu.turismospringboot.model.dto.MensajeDto;
import pe.edu.upeu.turismospringboot.model.entity.Mensaje;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.model.enums.EstadoMensaje;
import pe.edu.upeu.turismospringboot.repository.MensajeRepository;
import pe.edu.upeu.turismospringboot.repository.UsuarioRepository;

import org.springframework.security.access.AccessDeniedException;
import java.security.Principal;
import java.time.LocalDateTime;

@Controller
public class ChatController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private MensajeRepository mensajeRepository;

    @MessageMapping("/chat/enviar")
    public void procesarMensaje(@Payload MensajeDto mensajeDto, Principal principal) {
        if (principal == null) {
            System.out.println(">>> Principal es null");
            return;
        }

        String username = principal.getName();
        if (!username.equals(mensajeDto.getEmisorUsername())) {
            throw new AccessDeniedException("No puedes enviar mensajes en nombre de otro usuario");
        }

        try {
            Usuario emisor = usuarioRepository.findByUsername(mensajeDto.getEmisorUsername()).orElseThrow();
            Usuario receptor = usuarioRepository.findByUsername(mensajeDto.getReceptorUsername()).orElseThrow();

            Mensaje mensaje = new Mensaje();
            mensaje.setEmisor(emisor);
            mensaje.setReceptor(receptor);
            mensaje.setContenidoTexto(mensajeDto.getContenidoTexto());
            mensaje.setContenidoArchivo(mensajeDto.getContenidoArchivo());
            mensaje.setTipo(mensajeDto.getTipo());
            mensaje.setFechaEnvio(LocalDateTime.now());

            // ⚠️ Ignora si viene PENDIENTE o ERROR_ENVIO desde el frontend
            if (mensajeDto.getEstado() == EstadoMensaje.PENDIENTE || mensajeDto.getEstado() == EstadoMensaje.ERROR_ENVIO) {
                mensaje.setEstado(EstadoMensaje.ENVIADO);
            } else {
                mensaje.setEstado(mensajeDto.getEstado() != null ? mensajeDto.getEstado() : EstadoMensaje.ENVIADO);
            }

            mensajeRepository.save(mensaje);
            mensajeDto.setId(mensaje.getId());

            // Actualiza el DTO con los datos reales
            mensajeDto.setFechaEnvio(mensaje.getFechaEnvio());
            mensajeDto.setEstado(mensaje.getEstado());

            // Envía al receptor
            messagingTemplate.convertAndSendToUser(
                    receptor.getUsername(), "/queue/mensajes", mensajeDto
            );

            messagingTemplate.convertAndSendToUser(
                    emisor.getUsername(), "/queue/mensajes", mensajeDto
            );

        } catch (Exception e) {
            // 🔴 Notifica error al frontend (opcional)
            mensajeDto.setEstado(EstadoMensaje.ERROR_ENVIO);
            messagingTemplate.convertAndSendToUser(
                    username, "/queue/estado", mensajeDto
            );
        }
    }

    @MessageMapping("/chat/marcar-entregado")
    public void marcarComoEntregado(@Payload MensajeDto mensajeDto, Principal principal) {
        String username = principal.getName();

        mensajeRepository.findAllByEmisor_UsernameAndReceptor_UsernameAndEstado(
                mensajeDto.getEmisorUsername(), username, EstadoMensaje.ENVIADO
        ).forEach(mensaje -> {
            mensaje.setEstado(EstadoMensaje.ENTREGADO);
            mensajeRepository.save(mensaje);

            MensajeDto notificacion = new MensajeDto();
            notificacion.setId(mensaje.getId());
            notificacion.setEmisorUsername(mensaje.getEmisor().getUsername());
            notificacion.setReceptorUsername(mensaje.getReceptor().getUsername());
            notificacion.setEstado(EstadoMensaje.ENTREGADO);
            notificacion.setFechaEnvio(mensaje.getFechaEnvio());

            messagingTemplate.convertAndSendToUser(
                    mensaje.getEmisor().getUsername(), "/queue/estado", notificacion
            );
        });
    }

    @MessageMapping("/chat/marcar-leido")
    public void marcarComoLeido(@Payload MensajeDto mensajeDto, Principal principal) {
        String username = principal.getName();

        mensajeRepository.findAllByEmisor_UsernameAndReceptor_UsernameAndEstadoNot(
                mensajeDto.getEmisorUsername(), username, EstadoMensaje.LEIDO
        ).forEach(mensaje -> {
            mensaje.setEstado(EstadoMensaje.LEIDO);
            mensajeRepository.save(mensaje);

            MensajeDto notificacion = new MensajeDto();
            notificacion.setId(mensaje.getId());
            notificacion.setEmisorUsername(mensaje.getEmisor().getUsername());
            notificacion.setReceptorUsername(mensaje.getReceptor().getUsername());
            notificacion.setEstado(EstadoMensaje.LEIDO);
            notificacion.setFechaEnvio(mensaje.getFechaEnvio());

            messagingTemplate.convertAndSendToUser(
                    mensaje.getEmisor().getUsername(), "/queue/estado", notificacion
            );
        });
    }

    @MessageMapping("/chat/editar")
    public void editarMensaje(@Payload MensajeDto mensajeDto, Principal principal) {
        String username = principal.getName();

        if (mensajeDto.getId() == null) return;

        Mensaje mensaje = mensajeRepository.findById(mensajeDto.getId()).orElse(null);
        if (mensaje == null) return;

        if (!mensaje.getEmisor().getUsername().equals(username)) {
            throw new AccessDeniedException("No puedes editar mensajes de otro usuario");
        }

        mensaje.setContenidoTexto(mensajeDto.getContenidoTexto());
        mensaje.setContenidoArchivo(mensajeDto.getContenidoArchivo());
        mensaje.setTipo(mensajeDto.getTipo());
        mensaje.setFechaEnvio(LocalDateTime.now());
        mensaje.setEditado(true); // ✅ marcar como editado
        mensajeRepository.save(mensaje);

        MensajeDto mensajeEditado = new MensajeDto();
        mensajeEditado.setId(mensaje.getId());
        mensajeEditado.setEmisorUsername(mensaje.getEmisor().getUsername());
        mensajeEditado.setReceptorUsername(mensaje.getReceptor().getUsername());
        mensajeEditado.setContenidoTexto(mensaje.getContenidoTexto());
        mensajeEditado.setContenidoArchivo(mensaje.getContenidoArchivo());
        mensajeEditado.setTipo(mensaje.getTipo());
        mensajeEditado.setEstado(mensaje.getEstado());
        mensajeEditado.setFechaEnvio(mensaje.getFechaEnvio());
        mensajeEditado.setEditado(true); // ✅ enviar al frontend

        messagingTemplate.convertAndSendToUser(
                mensaje.getReceptor().getUsername(), "/queue/mensaje-editado", mensajeEditado
        );
        messagingTemplate.convertAndSendToUser(
                mensaje.getEmisor().getUsername(), "/queue/mensaje-editado", mensajeEditado
        );
    }
}