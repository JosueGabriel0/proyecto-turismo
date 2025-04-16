package pe.edu.upeu.turismospringboot.model.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "emprendimiento")
@Data
public class Emprendimiento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idEmprendimiento;

    private String nombre;
    private String descripcion;
    private String contacto;
    private String imagenUrl;

    @ManyToOne
    @JoinColumn(name = "id_lugar", nullable = false)
    private LugarTuristico lugar;

    @OneToOne(mappedBy = "emprendimiento", cascade = CascadeType.ALL)
    private Hotel hotel;
}