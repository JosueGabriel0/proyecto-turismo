package pe.edu.upeu.turismospringboot.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UbicacionDTO {
    private double lat;
    private double lng;
    private String titulo;
    private String tipo;
    private String descripcion;
    private String imagen;
}