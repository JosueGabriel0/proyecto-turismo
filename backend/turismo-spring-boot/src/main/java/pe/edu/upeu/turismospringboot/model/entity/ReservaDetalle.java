package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;
import pe.edu.upeu.turismospringboot.model.entity.Reserva;
import pe.edu.upeu.turismospringboot.model.enums.TipoServicio;

import java.time.LocalDateTime;

@Entity
@Data
public class ReservaDetalle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idReservaDetalle;

    @Column(nullable = false)
    private String descripcion;  // Ej: "Habitación doble", "Menú degustación", "Tour en kayak"

    private Integer cantidad;    // Ej: cantidad de productos, personas, noches, etc.

    private Double precioUnitario;

    private Double total; // precioUnitario * cantidad

    @Enumerated(EnumType.STRING)
    private TipoServicio tipoServicio; // Ej: "habitacion", "plato", "artesania", "actividad"

    private String observaciones; // Comentarios adicionales si los hay

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "reserva_id", nullable = false)
    private Reserva reserva;

    private LocalDateTime fechaCreacionReservaDetalle;
    private LocalDateTime fechaModificacionReservaDetalle;

    @PrePersist
    public void onCreate(){
        fechaCreacionReservaDetalle = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionReservaDetalle = LocalDateTime.now();
    }
}