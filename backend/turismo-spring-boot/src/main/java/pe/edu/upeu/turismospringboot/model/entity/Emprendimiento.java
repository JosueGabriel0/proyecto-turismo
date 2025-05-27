package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
public class Emprendimiento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idEmprendimiento;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(columnDefinition = "TEXT")
    private String descripcion;

    private String imagenUrl;

    private Double latitud;

    private Double longitud;

    @OneToMany(mappedBy = "emprendimiento", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<Reserva> reservas;

    @ManyToOne
    @JoinColumn(name = "familia_categoria_id")
    @JsonBackReference
    private FamiliaCategoria familiaCategoria;

    @OneToOne(mappedBy = "emprendimiento", cascade = CascadeType.ALL)
    @JsonBackReference
    private Usuario usuario;

    @OneToMany(mappedBy = "emprendimiento", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<ServicioTuristico> servicioTuristicos;

    private LocalDateTime fechaCreacionEmprendimiento;
    private LocalDateTime fechaModificacionEmprendimiento;

    @PrePersist
    public void onCreate(){
        fechaCreacionEmprendimiento = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionEmprendimiento = LocalDateTime.now();
    }
}