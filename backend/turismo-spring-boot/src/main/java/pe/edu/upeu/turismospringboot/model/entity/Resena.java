package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "resena")
@Data
public class Resena {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idResena;

    private String nombreUsuario;
    private String comentario;

    @Column(nullable = false)
    private int calificacion; // 1 a 5

    private LocalDate fecha;

    @ManyToOne
    @JoinColumn(name = "id_lugar", nullable = true)
    @JsonBackReference
    private LugarTuristico lugar;

    @ManyToOne
    @JoinColumn(name = "id_emprendimiento", nullable = true)
    @JsonBackReference
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