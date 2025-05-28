package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;
import pe.edu.upeu.turismospringboot.model.enums.EstadoReserva;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
public class Reserva {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idReserva;

    @Column(nullable = false)
    private LocalDateTime fechaHoraReserva;  // Fecha y hora cuando se realiza la reserva

    @Column(nullable = false)
    private LocalDateTime fechaHoraInicio;  // Fecha y hora de inicio de la reserva

    @Column(nullable = false)
    private LocalDateTime fechaHoraFin;  // Fecha y hora de finalización de la reserva

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private EstadoReserva estado;  // Estado de la reserva (pendiente, confirmada, cancelada, etc.)

    private Double totalGeneral;
    @ManyToOne
    @JoinColumn(name = "usuario_id", nullable = false)
    @JsonBackReference
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "emprendimiento_id", nullable = false)
    @JsonBackReference
    private Emprendimiento emprendimiento;

    @JsonManagedReference
    @OneToMany(mappedBy = "reserva", cascade = CascadeType.ALL)
    private List<ReservaDetalle> reservaDetalles;

    private LocalDateTime fechaCreacionReserva;
    private LocalDateTime fechaModificacionReserva;

    @PrePersist
    public void onCreate(){
        fechaCreacionReserva = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionReserva = LocalDateTime.now();
    }
}