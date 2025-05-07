package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
public class Noticia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idNoticia;

    private String titulo;

    @Lob
    private String contenido;

    private String imagenUrl;
    private LocalDateTime fechaPublicacion;

    @ManyToOne
    @JoinColumn(name = "id_autor", nullable = false)
    @JsonBackReference
    private Usuario autor;

    private LocalDateTime fechaCreacionNoticia;
    private LocalDateTime fechaModificacionNoticia;

    @PrePersist
    public void onCreate(){
        fechaCreacionNoticia = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionNoticia = LocalDateTime.now();
    }
}