package pe.edu.upeu.turismospringboot.service;

import pe.edu.upeu.turismospringboot.model.dto.CrearReservaRequest;
import pe.edu.upeu.turismospringboot.model.dto.ReservaResponseDTO;
import pe.edu.upeu.turismospringboot.model.entity.Reserva;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.model.enums.EstadoReserva;

import java.util.List;

public interface ReservaService {
    public ReservaResponseDTO crearReserva(CrearReservaRequest request, Usuario usuarioAutenticado);
    public ReservaResponseDTO actualizarEstadoReserva(Long reservaId, EstadoReserva nuevoEstado, Usuario usuarioAutenticado);
    public String obtenerNumeroEmprendedorPorIdEmprendimiento(Long idEmprendimiento);
    public List<Reserva> obtenerReservasPorIdUsuario(Long idUsuario);
    public Reserva obtenerReservaPorId(Long idReserva);
    public List<Reserva> obtenerReservasPorIdEmprendimiento(Long idEmprendimiento);
}
