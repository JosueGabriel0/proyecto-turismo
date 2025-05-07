package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
public class BitacoraAcceso {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idBitacora;

    @ManyToOne
    @JoinColumn(name = "id_usuario", nullable = false)
    @JsonBackReference
    private Usuario usuario;

    private LocalDateTime fechaHora;
    private String direccionIp;
    private boolean exito;

    private LocalDateTime fechaCreacionBitacoraAcceso;
    private LocalDateTime fechaModificacionBitacoraAcceso;

    @PrePersist
    public void onCreate(){
        fechaCreacionBitacoraAcceso = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionBitacoraAcceso = LocalDateTime.now();
    }
}