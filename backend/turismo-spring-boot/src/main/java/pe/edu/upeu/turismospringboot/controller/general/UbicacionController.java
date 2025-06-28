package pe.edu.upeu.turismospringboot.controller.general;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.turismospringboot.model.dto.UbicacionDTO;
import pe.edu.upeu.turismospringboot.service.UbicacionService;

import java.util.List;

@RestController
@RequestMapping("/general/ubicaciones")
@RequiredArgsConstructor
public class UbicacionController {

    private final UbicacionService ubicacionService;

    @GetMapping
    public List<UbicacionDTO> obtenerUbicaciones() {
        return ubicacionService.obtenerTodasLasUbicaciones();
    }
}