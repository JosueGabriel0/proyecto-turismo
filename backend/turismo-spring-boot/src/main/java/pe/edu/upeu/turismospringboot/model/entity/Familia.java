package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
public class Familia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idFamilia;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(length = 255)
    private String descripcion;

    private String imagenUrl;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "lugar_id", nullable = false)
    private Lugar lugar;

    @JsonManagedReference(value = "familia-familiaCategoria")
    @OneToMany(mappedBy = "familia", cascade = CascadeType.ALL)
    private List<FamiliaCategoria> familiaCategorias;

    private LocalDateTime fechaCreacionFamilia;
    private LocalDateTime fechaModificacionFamilia;

    @PrePersist
    public void onCreate(){
        fechaCreacionFamilia = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionFamilia = LocalDateTime.now();
    }
}