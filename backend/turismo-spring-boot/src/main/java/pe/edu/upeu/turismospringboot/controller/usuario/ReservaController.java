package pe.edu.upeu.turismospringboot.controller.usuario;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.turismospringboot.model.dto.CrearReservaRequest;
import pe.edu.upeu.turismospringboot.model.dto.ReservaResponseDTO;
import pe.edu.upeu.turismospringboot.model.entity.Reserva;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.service.ReservaService;

import java.util.List;

@RestController
@RequestMapping("/usuario/reserva")
@RequiredArgsConstructor
public class ReservaController {

    private final ReservaService reservaService;

    @PostMapping
    public ResponseEntity<ReservaResponseDTO> crearReserva(
            @RequestBody CrearReservaRequest request,
            @AuthenticationPrincipal Usuario usuarioAutenticado) {

        ReservaResponseDTO reservaCreada = reservaService.crearReserva(request, usuarioAutenticado);
        return ResponseEntity.ok(reservaCreada);
    }

    @GetMapping("/telefono/{idEmprendimiento}")
    public ResponseEntity<String> obtenerNumeroEmprendedorPorIdEmprendimiento(
            @PathVariable("idEmprendimiento") Long idEmprendimiento
    ){
        return ResponseEntity.ok(reservaService.obtenerNumeroEmprendedorPorIdEmprendimiento(idEmprendimiento));
    }

    @GetMapping("/idUsuario/{id}")
    public ResponseEntity<List<Reserva>> obtenerReservasPorIdUsuario(
            @PathVariable("id") Long id
    ){
        return ResponseEntity.ok(reservaService.obtenerReservasPorIdUsuario(id));
    }

    @GetMapping("/{idReserva}")
    public ResponseEntity<Reserva> obtenerReservaPorId(
            @PathVariable("idReserva") Long idReserva
    ){
        return ResponseEntity.ok(reservaService.obtenerReservaPorId(idReserva));
    }
}
