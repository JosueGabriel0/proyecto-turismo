package pe.edu.upeu.turismospringboot.model.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class CrearReservaRequest {
    private Long idEmprendimiento;
    private LocalDateTime fechaHoraInicio;
    private LocalDateTime fechaHoraFin;
    private List<CrearReservaDetalleRequest> detalles;
}