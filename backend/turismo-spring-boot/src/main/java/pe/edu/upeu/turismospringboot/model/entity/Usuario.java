package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;
import pe.edu.upeu.turismospringboot.model.enums.EstadoCuenta;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "usuario")
@Data
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idUsuario;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    private EstadoCuenta estado;

    @ManyToOne
    @JoinColumn(name = "id_rol", nullable = false)
    @JsonBackReference
    private Rol rol;

    @OneToOne
    @JoinColumn(name = "id_persona", unique = true)
    @JsonManagedReference
    private Persona persona;

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<BitacoraAcceso> bitacoraAccesoList = new ArrayList<>();

    @OneToMany(mappedBy = "autor", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<Noticia> noticias = new ArrayList<>();

    private LocalDateTime fechaCreacionUsuario;
    private LocalDateTime fechaModificacionUsuario;

    @PrePersist
    public void onCreate(){
        fechaCreacionUsuario = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionUsuario = LocalDateTime.now();
    }
}
