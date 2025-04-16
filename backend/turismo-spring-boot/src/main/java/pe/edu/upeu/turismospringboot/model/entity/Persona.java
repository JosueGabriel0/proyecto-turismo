package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Entity
@Table(name = "persona")
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
    private LocalDate fechaNacimiento;

    @OneToOne(mappedBy = "persona", cascade = CascadeType.ALL)
    @JsonBackReference
    private Usuario usuario;
}
