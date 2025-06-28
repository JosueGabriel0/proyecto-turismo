package pe.edu.upeu.turismospringboot.model.entity;

import jakarta.persistence.*;
import lombok.Data;
import pe.edu.upeu.turismospringboot.model.enums.EstadoMensaje;
import pe.edu.upeu.turismospringboot.model.enums.TipoMensaje;

import java.time.LocalDateTime;

@Entity
@Data
public class Mensaje {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Usuario emisor;

    @ManyToOne
    private Usuario receptor;

    private String contenidoTexto;
    private String contenidoArchivo;

    @Enumerated(EnumType.STRING)
    private TipoMensaje tipo; // TEXTO, IMAGEN, etc.

    @Enumerated(EnumType.STRING)
    private EstadoMensaje estado = EstadoMensaje.ENVIADO;

    private boolean editado = false;

    private LocalDateTime fechaEnvio;
}