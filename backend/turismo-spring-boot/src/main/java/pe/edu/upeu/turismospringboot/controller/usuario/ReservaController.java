package pe.edu.upeu.turismospringboot.controller.usuario;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pe.edu.upeu.turismospringboot.model.dto.CrearReservaRequest;
import pe.edu.upeu.turismospringboot.model.dto.ReservaResponseDTO;
import pe.edu.upeu.turismospringboot.model.entity.Reserva;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.service.ReservaService;

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
}
