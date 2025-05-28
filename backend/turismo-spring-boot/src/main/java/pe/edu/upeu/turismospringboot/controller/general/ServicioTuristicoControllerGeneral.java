package pe.edu.upeu.turismospringboot.controller.general;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pe.edu.upeu.turismospringboot.model.entity.ServicioTuristico;
import pe.edu.upeu.turismospringboot.service.ServicioTuristicoService;

import java.util.List;

@RestController
@RequestMapping("/general/servicioTuristico")
public class ServicioTuristicoControllerGeneral {

    @Autowired
    private ServicioTuristicoService servicioTuristicoService;

    @GetMapping("/emprendimiento/{idEmprendimiento}")
    public ResponseEntity<List<ServicioTuristico>> buscarServicioTuristicoPorIdEmprendimiento(
            @PathVariable("idEmprendimiento") Long idEmprendimiento
    ) {
        return ResponseEntity.ok(servicioTuristicoService.buscarServicioTuristicoPorIdEmprendimiento(idEmprendimiento));
    }
}
