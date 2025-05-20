package pe.edu.upeu.turismospringboot.model.dto;

import lombok.Data;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class FamiliaCategoriaDto {
    private Long idFamiliaCategoria;
    private Long idFamilia;
    private String nombreFamilia;
    private Long idCategoria;
    private String nombreCategoria;
    private List<Emprendimiento> emprendimientos;
    private LocalDateTime fechaCreacionFamiliaCategoria;
    private LocalDateTime fechaModificacionFamiliaCategoria;
}
