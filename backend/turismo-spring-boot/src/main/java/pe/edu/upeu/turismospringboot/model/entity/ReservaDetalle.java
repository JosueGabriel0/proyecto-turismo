package pe.edu.upeu.turismospringboot.model.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
public class ReservaDetalle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idReservaDetalle;

    @Column(nullable = false)
    private String descripcion;  // Descripción del detalle (por ejemplo, tipo de servicio o actividad)

    @Column(nullable = false)
    private double precio;  // Precio asociado al detalle de la reserva

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