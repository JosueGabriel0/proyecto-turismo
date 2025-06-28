package pe.edu.upeu.turismospringboot.model.dto;

import lombok.Data;
import pe.edu.upeu.turismospringboot.model.enums.EstadoMensaje;

import java.time.LocalDateTime;

@Data
public class ChatResumenDto {
    private String username;
    private String nombreCompleto;
    private String ultimoMensaje;
    private LocalDateTime hora;
    private String avatarUrl;
    private EstadoMensaje estadoUltimoMensaje;
}
