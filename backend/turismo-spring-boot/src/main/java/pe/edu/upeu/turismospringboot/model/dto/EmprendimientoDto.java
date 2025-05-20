package pe.edu.upeu.turismospringboot.model.dto;

import lombok.Data;

@Data
public class EmprendimientoDto {
    private String nombre;
    private String descripcion;
    private Double latitud;
    private Double longitud;
    private Long idFamiliaCategoria;
}
