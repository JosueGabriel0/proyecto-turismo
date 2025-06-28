package pe.edu.upeu.turismospringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pe.edu.upeu.turismospringboot.model.dto.ChatResumenDto;
import pe.edu.upeu.turismospringboot.model.dto.MensajeDto;
import pe.edu.upeu.turismospringboot.model.entity.Mensaje;
import pe.edu.upeu.turismospringboot.model.enums.EstadoMensaje;
import pe.edu.upeu.turismospringboot.repository.MensajeRepository;
import pe.edu.upeu.turismospringboot.service.MensajeService;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.repository.UsuarioRepository;

@Service
public class MensajeServiceImpl implements MensajeService {

    @Autowired
    private MensajeRepository mensajeRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    public List<MensajeDto> obtenerHistorialEntre(Usuario usuarioAutenticado, Long otroUsuarioId) {
        Long authId = usuarioAutenticado.getIdUsuario();

        // Asegura que el otro usuario exista
        Usuario otroUsuario = usuarioRepository.findById(otroUsuarioId)
                .orElseThrow(() -> new RuntimeException("Usuario receptor no existe"));

        // Consulta mensajes entre ambos en cualquier dirección
        List<Mensaje> mensajes = mensajeRepository
                .findByEmisor_IdUsuarioAndReceptor_IdUsuarioOrEmisor_IdUsuarioAndReceptor_IdUsuarioOrderByFechaEnvioAsc(
                        authId, otroUsuarioId, otroUsuarioId, authId
                );

        // Lógica de seguridad: solo permitir si el usuario está implicado
        boolean autorizado = mensajes.stream().anyMatch(m ->
                m.getEmisor().getIdUsuario().equals(authId) || m.getReceptor().getIdUsuario().equals(authId)
        );

        if (!autorizado) {
            throw new SecurityException("No autorizado para ver esta conversación");
        }

        return mensajes.stream().map(this::convertirADto).collect(Collectors.toList());
    }

    private MensajeDto convertirADto(Mensaje m) {
        MensajeDto dto = new MensajeDto();
        dto.setId(m.getId());
        dto.setEmisorUsername(m.getEmisor().getUsername());
        dto.setReceptorUsername(m.getReceptor().getUsername());
        dto.setContenidoTexto(m.getContenidoTexto());
        dto.setContenidoArchivo(m.getContenidoArchivo());
        dto.setTipo(m.getTipo());
        dto.setEstado(m.getEstado());
        dto.setEditado(m.isEditado());
        dto.setFechaEnvio(m.getFechaEnvio());
        return dto;
    }

    @Override
    public List<ChatResumenDto> obtenerChatsRecientes(Long usuarioId) {
        List<Mensaje> mensajes = mensajeRepository.findMensajesRecientesPorUsuario(usuarioId);

        Map<String, Mensaje> ultimosMensajesPorConversacion = new LinkedHashMap<>();

        for (Mensaje mensaje : mensajes) {
            Long otroId = mensaje.getEmisor().getIdUsuario().equals(usuarioId)
                    ? mensaje.getReceptor().getIdUsuario()
                    : mensaje.getEmisor().getIdUsuario();

            String key = usuarioId < otroId
                    ? usuarioId + "-" + otroId
                    : otroId + "-" + usuarioId;

            if (!ultimosMensajesPorConversacion.containsKey(key)) {
                ultimosMensajesPorConversacion.put(key, mensaje);
            }
        }

        return ultimosMensajesPorConversacion.values().stream()
                .map(m -> convertirAResumenDto(m, usuarioId))
                .toList();
    }

    private ChatResumenDto convertirAResumenDto(Mensaje m, Long usuarioId) {
        Usuario otroUsuario = m.getEmisor().getIdUsuario().equals(usuarioId)
                ? m.getReceptor()
                : m.getEmisor();

        ChatResumenDto dto = new ChatResumenDto();
        dto.setUsername(otroUsuario.getUsername());

        if (otroUsuario.getPersona() != null) {
            String nombre = otroUsuario.getPersona().getNombres();
            String apellidos = otroUsuario.getPersona().getApellidos();
            dto.setNombreCompleto(nombre + " " + (apellidos != null ? apellidos : ""));
            dto.setAvatarUrl(otroUsuario.getPersona().getFotoPerfil());
        } else {
            dto.setNombreCompleto(otroUsuario.getUsername());
            dto.setAvatarUrl(null);
        }

        dto.setUltimoMensaje(m.getContenidoTexto() != null ? m.getContenidoTexto() : "[Archivo]");
        dto.setHora(m.getFechaEnvio());

        dto.setEstadoUltimoMensaje(m.getEstado());

        return dto;
    }
}