package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
public class Lugar {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idLugar;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(columnDefinition = "TEXT")
    private String descripcion;

    @Column(length = 200)
    private String direccion;

    @Column(length = 100)
    private String ciudad;

    @Column(length = 100)
    private String provincia;

    @Column(length = 100)
    private String pais;

    private Double latitud;

    private Double longitud;

    private String imagenUrl;

    @JsonManagedReference
    @OneToMany(mappedBy = "lugar", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Familia> familias;

    private LocalDateTime fechaCreacionLugar;
    private LocalDateTime fechaModificacionLugar;

    @PrePersist
    public void onCreate(){
        fechaCreacionLugar = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionLugar = LocalDateTime.now();
    }
}