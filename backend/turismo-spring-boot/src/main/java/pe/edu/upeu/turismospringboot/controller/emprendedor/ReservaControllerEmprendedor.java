package pe.edu.upeu.turismospringboot.controller.emprendedor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.turismospringboot.model.dto.CrearReservaRequest;
import pe.edu.upeu.turismospringboot.model.dto.ReservaResponseDTO;
import pe.edu.upeu.turismospringboot.model.entity.Reserva;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.model.enums.EstadoReserva;
import pe.edu.upeu.turismospringboot.service.ReservaService;

import java.util.List;

@RestController
@RequestMapping("/emprendedor/reserva")
public class ReservaControllerEmprendedor {
    @Autowired
    private ReservaService reservaService;

    @PostMapping
    public ResponseEntity<ReservaResponseDTO> crearReserva(
            @RequestBody CrearReservaRequest request,
            @AuthenticationPrincipal Usuario usuarioAutenticado) {

        ReservaResponseDTO reservaCreada = reservaService.crearReserva(request, usuarioAutenticado);
        return ResponseEntity.ok(reservaCreada);
    }

    @PutMapping("/{id}/estado")
    public ResponseEntity<ReservaResponseDTO> actualizarEstado(
            @PathVariable Long id,
            @RequestParam EstadoReserva nuevoEstado,
            @AuthenticationPrincipal Usuario usuarioAutenticado) {
        ReservaResponseDTO dto = reservaService.actualizarEstadoReserva(id, nuevoEstado, usuarioAutenticado);
        return ResponseEntity.ok(dto);
    }

    @GetMapping("/idEmprendimiento/{idEmprendimiento}")
    public ResponseEntity<List<Reserva>> obtenerReservasPorIdEmprendimiento(
            @PathVariable("idEmprendimiento") Long idEmprendimiento
    ){
        return ResponseEntity.ok(reservaService.obtenerReservasPorIdEmprendimiento(idEmprendimiento));
    }

    @GetMapping("/{idReserva}")
    public ResponseEntity<Reserva> obtenerReservaPorId(
            @PathVariable("idReserva") Long idReserva
    ){
        return ResponseEntity.ok(reservaService.obtenerReservaPorId(idReserva));
    }
}
