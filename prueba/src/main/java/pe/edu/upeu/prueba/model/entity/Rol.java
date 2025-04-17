package pe.edu.upeu.prueba.model.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "rol")
@Data
public class Rol {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idRol;

    @Column(nullable = false, unique = true)
    private String nombre;

    @OneToMany(mappedBy = "rol", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<Usuario> usuarios = new ArrayList<>();

    private LocalDateTime fechaCreacionRol;
    private LocalDateTime fechaModificacionRol;

    @PrePersist
    public void onCreate(){
        fechaCreacionRol = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionRol = LocalDateTime.now();
    }
}
