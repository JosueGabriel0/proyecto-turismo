package pe.edu.upeu.turismospringboot.model.dto;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Data;
import pe.edu.upeu.turismospringboot.model.enums.EstadoMensaje;
import pe.edu.upeu.turismospringboot.model.enums.TipoMensaje;

import java.time.LocalDateTime;

@Data
public class MensajeDto {
    private Long id;

    private String emisorUsername;
    private String receptorUsername;

    private String contenidoTexto;
    private String contenidoArchivo;

    private TipoMensaje tipo;

    @Enumerated(EnumType.STRING)
    private EstadoMensaje estado;

    private boolean editado = false;

    private LocalDateTime fechaEnvio;
}