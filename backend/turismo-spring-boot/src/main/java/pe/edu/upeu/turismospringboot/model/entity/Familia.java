package pe.edu.upeu.turismospringboot.model.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
public class Familia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(length = 255)
    private String descripcion;

    private String imagenUrl;

    @ManyToOne
    @JoinColumn(name = "lugar_id", nullable = false)
    private Lugar lugar;

    @OneToMany(mappedBy = "familia", cascade = CascadeType.ALL)
    private List<Categoria> categorias;

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