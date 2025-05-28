package pe.edu.upeu.turismospringboot.service.impl;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pe.edu.upeu.turismospringboot.model.dto.CrearReservaRequest;
import pe.edu.upeu.turismospringboot.model.dto.ReservaResponseDTO;
import pe.edu.upeu.turismospringboot.model.entity.*;
import pe.edu.upeu.turismospringboot.model.enums.EstadoReserva;
import pe.edu.upeu.turismospringboot.repository.EmprendimientoRepository;
import pe.edu.upeu.turismospringboot.repository.ReservaRepository;
import pe.edu.upeu.turismospringboot.repository.ServicioTuristicoRepository;
import pe.edu.upeu.turismospringboot.repository.UsuarioRepository;
import pe.edu.upeu.turismospringboot.service.ReservaService;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReservaServiceImpl implements ReservaService {

    private final ReservaRepository reservaRepository;
    private final EmprendimientoRepository emprendimientoRepository;
    private final ServicioTuristicoRepository servicioTuristicoRepository;
    private final UsuarioRepository usuarioRepository;

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

        // Calcular los detalles
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

// Calcular el total general sumando todos los `total` de los detalles
        double totalGeneral = detalles.stream()
                .mapToDouble(ReservaDetalle::getTotal)
                .sum();

// Asignar el total general a la reserva
        reserva.setTotalGeneral(totalGeneral);

// Asignar los detalles a la reserva
        reserva.setReservaDetalles(detalles);

// Guardar la reserva
        Reserva reservaGuardada = reservaRepository.save(reserva);

        return new ReservaResponseDTO(reservaGuardada);
    }

    @Transactional
    @Override
    public ReservaResponseDTO actualizarEstadoReserva(Long reservaId, EstadoReserva nuevoEstado, Usuario usuarioAutenticado) {
        // Buscar la reserva
        Reserva reserva = reservaRepository.findById(reservaId)
                .orElseThrow(() -> new RuntimeException("Reserva no encontrada"));

        // Verificar que el usuario autenticado es dueño del emprendimiento de la reserva
        if (!reserva.getEmprendimiento().getUsuario().getIdUsuario().equals(usuarioAutenticado.getIdUsuario())) {
            throw new RuntimeException("No tiene permisos para modificar esta reserva");
        }

        // Validar transiciones permitidas (opcional pero recomendable)
        if (reserva.getEstado() == EstadoReserva.CANCELADA || reserva.getEstado() == EstadoReserva.RECHAZADA) {
            throw new RuntimeException("No se puede cambiar el estado de una reserva cancelada o rechazada");
        }

        // Actualizar estado
        reserva.setEstado(nuevoEstado);

        // Guardar y devolver respuesta
        reservaRepository.save(reserva);
        return new ReservaResponseDTO(reserva);
    }

    @Override
    public String obtenerNumeroEmprendedorPorIdEmprendimiento(Long idEmprendimiento){
        Emprendimiento emprendimiento = emprendimientoRepository.findById(idEmprendimiento).orElseThrow(() -> new RuntimeException("Emprendimiento con id"+idEmprendimiento+"no encontrado"));
        String numeroDeTelefono = emprendimiento.getUsuario().getPersona().getTelefono();
        return numeroDeTelefono;
    }

    @Override
    public List<Reserva> obtenerReservasPorIdUsuario(Long idUsuario){
        Usuario usuarioEncontrado = usuarioRepository.findById(idUsuario).orElseThrow(() -> new RuntimeException("Usuario con id "+idUsuario+" no encontrado"));

        List<Reserva> reservas = usuarioEncontrado.getReservas();
        return reservas;
    }

    @Override
    public Reserva obtenerReservaPorId(Long idReserva){
        return reservaRepository.findById(idReserva).orElseThrow(
                () -> new RuntimeException("Reserva con id "+idReserva+" no encontrado")
        );
    }

    @Override
    public List<Reserva> obtenerReservasPorIdEmprendimiento(Long idEmprendimiento){
        Emprendimiento emprendimientoEncontrado = emprendimientoRepository.findById(idEmprendimiento).orElseThrow(
                () -> new RuntimeException("No se encontro el emprendimiento con id "+ idEmprendimiento)
        );
        List<Reserva> reservas = emprendimientoEncontrado.getReservas();
        return reservas;
    }
}