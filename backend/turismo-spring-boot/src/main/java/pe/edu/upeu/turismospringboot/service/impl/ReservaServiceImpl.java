package pe.edu.upeu.turismospringboot.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pe.edu.upeu.turismospringboot.model.dto.CrearReservaRequest;
import pe.edu.upeu.turismospringboot.model.dto.ReservaResponseDTO;
import pe.edu.upeu.turismospringboot.model.entity.*;
import pe.edu.upeu.turismospringboot.model.enums.EstadoReserva;
import pe.edu.upeu.turismospringboot.repository.EmprendimientoRepository;
import pe.edu.upeu.turismospringboot.repository.ReservaRepository;
import pe.edu.upeu.turismospringboot.repository.ServicioTuristicoRepository;
import pe.edu.upeu.turismospringboot.service.ReservaService;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReservaServiceImpl implements ReservaService {

    private final ReservaRepository reservaRepository;
    private final EmprendimientoRepository emprendimientoRepository;
    private final ServicioTuristicoRepository servicioTuristicoRepository;

    @Override
    public ReservaResponseDTO crearReserva(CrearReservaRequest request, Usuario usuarioAutenticado) {
        Emprendimiento emprendimiento = emprendimientoRepository.findById(request.getIdEmprendimiento())
                .orElseThrow(() -> new RuntimeException("Emprendimiento no encontrado"));

        Reserva reserva = new Reserva();
        reserva.setUsuario(usuarioAutenticado);
        reserva.setEmprendimiento(emprendimiento);
        reserva.setFechaHoraInicio(request.getFechaHoraInicio());
        reserva.setFechaHoraFin(request.getFechaHoraFin());
        reserva.setFechaHoraReserva(LocalDateTime.now());
        reserva.setEstado(EstadoReserva.PENDIENTE);

        List<ReservaDetalle> detalles = request.getDetalles().stream()
                .map(detalleRequest -> {
                    ServicioTuristico servicio = servicioTuristicoRepository.findById(detalleRequest.getIdServicioTuristico())
                            .orElseThrow(() -> new RuntimeException("Servicio turístico no encontrado"));

                    ReservaDetalle detalle = new ReservaDetalle();
                    detalle.setDescripcion(servicio.getNombre());
                    detalle.setCantidad(detalleRequest.getCantidad());
                    detalle.setPrecioUnitario(servicio.getPrecioUnitario());
                    detalle.setTotal(servicio.getPrecioUnitario() * detalleRequest.getCantidad());
                    detalle.setTipoServicio(servicio.getTipoServicio());
                    detalle.setObservaciones(detalleRequest.getObservaciones());
                    detalle.setReserva(reserva);
                    return detalle;
                }).toList();

        reserva.setReservaDetalles(detalles);
        Reserva reservaGuardada = reservaRepository.save(reserva);

        return new ReservaResponseDTO(reservaGuardada);
    }

    @Override
    public String obtenerNumeroEmprendedorPorIdEmprendimiento(Long idEmprendimiento){
        Emprendimiento emprendimiento = emprendimientoRepository.findById(idEmprendimiento).orElseThrow(() -> new RuntimeException("Emprendimiento con id"+idEmprendimiento+"no encontrado"));
        String numeroDeTelefono = emprendimiento.getUsuario().getPersona().getTelefono();
        return numeroDeTelefono;
    }
}