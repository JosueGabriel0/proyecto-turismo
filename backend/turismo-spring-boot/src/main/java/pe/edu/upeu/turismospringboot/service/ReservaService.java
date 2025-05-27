package pe.edu.upeu.turismospringboot.service;

import pe.edu.upeu.turismospringboot.model.dto.CrearReservaRequest;
import pe.edu.upeu.turismospringboot.model.dto.ReservaResponseDTO;
import pe.edu.upeu.turismospringboot.model.entity.Reserva;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;

public interface ReservaService {
    public ReservaResponseDTO crearReserva(CrearReservaRequest request, Usuario usuarioAutenticado);
    public String obtenerNumeroEmprendedorPorIdEmprendimiento(Long idEmprendimiento);
}
