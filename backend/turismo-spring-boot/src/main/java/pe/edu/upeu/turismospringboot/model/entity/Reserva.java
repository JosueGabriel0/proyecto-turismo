package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;
import pe.edu.upeu.turismospringboot.model.enums.EstadoReserva;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "reserva")
@Data
public class Reserva {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idReserva;

    @ManyToOne
    @JoinColumn(name = "id_hotel", nullable = false)
    @JsonBackReference
    private Hotel hotel;

    private String nombreCliente;
    private String emailCliente;

    private LocalDate fechaCheckin;
    private LocalDate fechaCheckout;
    private LocalDate fechaReserva;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private EstadoReserva estado; // Ej: "pendiente", "confirmada", "cancelada"

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