package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
public class Resena {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idResena;

    @Column(nullable = false)
    private String comentario;

    @Column(nullable = false)
    private int calificacion;  // Calificación en una escala, por ejemplo, 1 a 5

    @ManyToOne
    @JoinColumn(name = "usuario_id", nullable = false)
    @JsonBackReference
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "emprendimiento_id", nullable = false)
    private Emprendimiento emprendimiento;

    private LocalDateTime fechaCreacionResena;
    private LocalDateTime fechaModificacionResena;

    @PrePersist
    public void onCreate(){
        fechaCreacionResena = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionResena = LocalDateTime.now();
    }
}