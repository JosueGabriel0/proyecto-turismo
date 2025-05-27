package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;
import pe.edu.upeu.turismospringboot.model.enums.TipoServicio;

import java.time.LocalDateTime;

@Entity
@Data
public class ServicioTuristico {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idServicio;

    @Column(nullable = false)
    private String nombre; // Ej: "Habitación doble", "Desayuno continental", "Tour en kayak"

    private String descripcion;

    private Double precioUnitario;

    private TipoServicio tipoServicio;

    private String imagenUrl;

    @ManyToOne
    @JoinColumn(name = "emprendimiento_id", nullable = false)
    @JsonBackReference
    private Emprendimiento emprendimiento;

    private LocalDateTime fechaCreacion;
    private LocalDateTime fechaModificacion;

    @PrePersist
    public void onCreate(){
        fechaCreacion = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacion = LocalDateTime.now();
    }
}