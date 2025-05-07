package pe.edu.upeu.turismospringboot.model.dto;

import lombok.Data;

@Data
public class LugarDto {

    private String nombre;
    private String descripcion;
    private String direccion;
    private String ciudad;
    private String provincia;
    private String pais;
    private Double latitud;
    private Double longitud;
}
