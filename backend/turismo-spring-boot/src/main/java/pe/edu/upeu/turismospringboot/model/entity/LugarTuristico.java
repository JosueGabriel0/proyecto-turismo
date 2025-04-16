package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.util.*;

@Entity
@Table(name = "lugar_turistico")
@Data
public class LugarTuristico {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idLugar;

    private String nombre;
    private String descripcion;
    private String ubicacion;
    private String imagenUrl;

    @ManyToOne
    @JoinColumn(name = "id_categoria", nullable = false)
    @JsonBackReference
    private Categoria categoria;

    @OneToMany(mappedBy = "lugar", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<Emprendimiento> emprendimientos = new ArrayList<>();

    @OneToMany(mappedBy = "lugar", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<Resena> resenas = new ArrayList<>();
}