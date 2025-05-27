package pe.edu.upeu.turismospringboot.controller.general;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.EmprendimientoDto;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;
import pe.edu.upeu.turismospringboot.service.EmprendimientoService;

import java.util.List;

@RestController
@RequestMapping("/general/emprendimiento")
public class EmprendimientoControllerGeneral {
    @Autowired
    private EmprendimientoService emprendimientoService;

    @GetMapping
    public ResponseEntity<List<Emprendimiento>> obtenerEmprendimientos() {
        return ResponseEntity.ok(emprendimientoService.getEmprendimientos());
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Emprendimiento>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(emprendimientoService.buscarPorNombre(nombre));
    }

    @GetMapping("/{idEmprendimiento}")
    public ResponseEntity<Emprendimiento> obtenerEmprendimientoPorId(@PathVariable Long idEmprendimiento) {
        return ResponseEntity.ok(emprendimientoService.getEmprendimientoById(idEmprendimiento));
    }
}