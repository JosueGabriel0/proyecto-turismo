package pe.edu.upeu.turismospringboot.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DashboardAdminDTO {
    private Long totalUsuarios;
    private Long totalReservas;
    private Long totalEmprendimientos;
    private Long totalResenas;
    private Map<String, Long> reservasPorEstado;
    private Map<String, Long> emprendimientosPorCategoria;
}