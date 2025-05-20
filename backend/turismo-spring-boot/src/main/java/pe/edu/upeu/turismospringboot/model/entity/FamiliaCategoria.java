package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
public class FamiliaCategoria {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idFamiliaCategoria;

    @JsonBackReference(value = "familia-familiaCategoria")
    @ManyToOne
    @JoinColumn(name = "familia_id")
    private Familia familia;

    @JsonBackReference(value = "categoria-familiaCategoria")
    @ManyToOne
    @JoinColumn(name = "categoria_id")
    private Categoria categoria;

    @JsonManagedReference
    @OneToMany(mappedBy = "familiaCategoria")
    private List<Emprendimiento> emprendimientos;

    private LocalDateTime fechaCreacionFamiliaCategoria;
    private LocalDateTime fechaModificacionFamiliaCategoria;

    @PrePersist
    public void onCreate(){
        fechaCreacionFamiliaCategoria = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionFamiliaCategoria = LocalDateTime.now();
    }
}