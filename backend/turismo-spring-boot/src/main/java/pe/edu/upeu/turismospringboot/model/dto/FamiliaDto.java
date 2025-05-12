package pe.edu.upeu.turismospringboot.model.dto;

import jakarta.persistence.*;
import lombok.Data;
import pe.edu.upeu.turismospringboot.model.entity.Categoria;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class FamiliaDto {
    private String nombre;
    private String descripcion;
    private String nombreLugar;
}
