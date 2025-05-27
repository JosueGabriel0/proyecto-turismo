package pe.edu.upeu.turismospringboot.model.dto;

import lombok.Data;
import pe.edu.upeu.turismospringboot.model.entity.Reserva;

import java.time.LocalDateTime;

@Data
public class ReservaResponseDTO {
    private Long idReserva;
    private String estado;
    private UsuarioDTO usuario;
    private Long idEmprendimiento;
    private LocalDateTime fechaHoraInicio;
    private LocalDateTime fechaHoraFin;
    private LocalDateTime fechaHoraReserva;

    // Constructor para crear desde entidad Reserva
    public ReservaResponseDTO(Reserva reserva) {
        this.idReserva = reserva.getIdReserva();
        this.estado = reserva.getEstado().name();
        this.usuario = new UsuarioDTO(reserva.getUsuario());
        this.idEmprendimiento = reserva.getEmprendimiento() != null ? reserva.getEmprendimiento().getIdEmprendimiento() : null;
        this.fechaHoraInicio = reserva.getFechaHoraInicio();
        this.fechaHoraFin = reserva.getFechaHoraFin();
        this.fechaHoraReserva = reserva.getFechaHoraReserva();
    }
}