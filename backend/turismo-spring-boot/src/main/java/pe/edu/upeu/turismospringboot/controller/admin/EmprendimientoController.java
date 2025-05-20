package pe.edu.upeu.turismospringboot.controller.admin;

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
@RequestMapping("/admin/emprendimiento")
public class EmprendimientoController {
    @Autowired
    private EmprendimientoService emprendimientoService;

    @GetMapping
    public ResponseEntity<List<Emprendimiento>> obtenerEmprendimientos() {
        return ResponseEntity.ok(emprendimientoService.getEmprendimientos());
    }

    @GetMapping("/{idEmprendimiento}")
    public ResponseEntity<Emprendimiento> obtenerEmprendimientoPorId(@PathVariable Long idEmprendimiento) {
        return ResponseEntity.ok(emprendimientoService.getEmprendimientoById(idEmprendimiento));
    }

    @PostMapping
    public ResponseEntity<Emprendimiento> crearEmprendimiento(
            @RequestPart(value = "emprendimiento") String emprendimientoJson,
            @RequestPart(value = "file", required = false) MultipartFile file
    ) {
        try{
            ObjectMapper objectMapper = new ObjectMapper();
            EmprendimientoDto emprendimientoDto = objectMapper.readValue(emprendimientoJson, EmprendimientoDto.class);

            Emprendimiento nuevoEmprendimiento = emprendimientoService.postEmprendimiento(emprendimientoDto, file);
            return ResponseEntity.status(HttpStatus.CREATED).body(nuevoEmprendimiento);
        }catch (Exception e){
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PutMapping("/{idEmprendimiento}")
    public ResponseEntity<Emprendimiento> actualizarEmprendimiento(
            @PathVariable Long idEmprendimiento,
            @RequestPart(value = "emprendimiento") String emprendimientoJson,
            @RequestPart(value = "file", required = false) MultipartFile file
    ) {
        try{
            ObjectMapper objectMapper = new ObjectMapper();
            EmprendimientoDto emprendimientoDto = objectMapper.readValue(emprendimientoJson, EmprendimientoDto.class);

            Emprendimiento nuevoEmprendimiento = emprendimientoService.putEmprendimiento(idEmprendimiento, emprendimientoDto, file);
            return ResponseEntity.ok(nuevoEmprendimiento);
        }catch (Exception e){
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @DeleteMapping("/{idEmprendimiento}")
    public ResponseEntity<String> eliminarEmprendimiento(@PathVariable Long idEmprendimiento){
        try {
            emprendimientoService.deleteEmprendimiento(idEmprendimiento);
            return ResponseEntity.ok("Emprendimiento eliminado");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Emprendimiento>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(emprendimientoService.buscarPorNombre(nombre));
    }
}
