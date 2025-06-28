package pe.edu.upeu.turismospringboot.model.dto;

import lombok.Data;

@Data
public class ServicioTuristicoDto {

    private Long idServicio;

    private String nombre; // Ej: "Habitación doble", "Desayuno continental", "Tour en kayak"

    private String descripcion;

    private Double precioUnitario;

    private String tipoServicio;

    private String nombreEmprendimiento;
}
