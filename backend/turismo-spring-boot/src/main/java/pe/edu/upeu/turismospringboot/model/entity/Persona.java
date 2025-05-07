package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Data
public class Persona {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idPersona;

    @Column(nullable = false)
    private String nombres;

    private String apellidos;
    private String tipoDocumento;
    private String numeroDocumento;
    private String telefono;
    private String direccion;
    private String correoElectronico;
    private String fotoPerfil;
    private LocalDate fechaNacimiento;

    @OneToOne(mappedBy = "persona", cascade = CascadeType.ALL)
    @JsonBackReference
    private Usuario usuario;

    private LocalDateTime fechaCreacionPersona;
    private LocalDateTime fechaModificacionPersona;

    @PrePersist
    public void onCreate(){
        fechaCreacionPersona = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionPersona = LocalDateTime.now();
    }
}
