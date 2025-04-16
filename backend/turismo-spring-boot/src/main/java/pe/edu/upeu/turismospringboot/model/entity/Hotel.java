package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "hotel")
@Data
public class Hotel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idHotel;

    private String nombre;
    private String descripcion;
    private String direccion;
    private String contacto;
    private Integer capacidadTotal;

    @OneToOne
    @JoinColumn(name = "id_emprendimiento", nullable = false)
    @JsonManagedReference
    private Emprendimiento emprendimiento;

    @OneToMany(mappedBy = "hotel", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<Reserva> reservas = new ArrayList<>();

    private LocalDateTime fechaCreacionHotel;
    private LocalDateTime fechaModificacionHotel;

    @PrePersist
    public void onCreate(){
        fechaCreacionHotel = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionHotel = LocalDateTime.now();
    }
}