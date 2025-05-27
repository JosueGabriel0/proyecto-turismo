package pe.edu.upeu.turismospringboot.model.dto;

import lombok.Data;

@Data
public class CrearReservaDetalleRequest {
    private Long idServicioTuristico;
    private Integer cantidad;
    private String observaciones;
}