package pe.edu.upeu.turismospringboot.controller.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.ServicioTuristicoDto;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;
import pe.edu.upeu.turismospringboot.model.entity.ServicioTuristico;
import pe.edu.upeu.turismospringboot.service.ServicioTuristicoService;

import java.util.List;

@RestController
@RequestMapping("/admin/servicioTuristico")
public class ServicioTuristicoController {
    @Autowired
    private ServicioTuristicoService servicioTuristicoService;

    @GetMapping
    public ResponseEntity<List<ServicioTuristico>> obtenerServiciosTuristicos() {
        return ResponseEntity.ok(servicioTuristicoService.getServicioTuristicos());
    }

    @GetMapping("/{idServicio}")
    public ResponseEntity<ServicioTuristico> obtenerServicioTuristicoById(@PathVariable("idServicio") Long idServicio) {
        return ResponseEntity.ok(servicioTuristicoService.getServicioTuristicoById(idServicio));
    }

    @PostMapping
    public ResponseEntity<ServicioTuristico> crearServicioTuristico(
            @RequestPart(value = "servicioTuristico") String servicioTuristicoJson,
            @RequestPart(value = "file", required = false) MultipartFile file
    ) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();

            ServicioTuristicoDto servicioTuristicoDto = objectMapper.readValue(servicioTuristicoJson, ServicioTuristicoDto.class);
            return ResponseEntity.status(HttpStatus.CREATED).body(servicioTuristicoService.postServicioTuristico(servicioTuristicoDto, file));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/{idServicio}")
    public ResponseEntity<ServicioTuristico> actualizarServicioTuristico(
            @PathVariable("idServicio") Long idServicio,
            @RequestPart(value = "servicioTuristico") String servicioTuristicoJson,
            @RequestPart(value = "file", required = false) MultipartFile file
    ){
        try {
            ObjectMapper objectMapper = new ObjectMapper();

            ServicioTuristicoDto servicioTuristicoDto = objectMapper.readValue(servicioTuristicoJson, ServicioTuristicoDto.class);
            return ResponseEntity.ok(servicioTuristicoService.putServicioTuristico(idServicio, servicioTuristicoDto, file));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @DeleteMapping("/{idServicio}")
    public ResponseEntity<String> eliminarServicioTuristico(@PathVariable("idServicio") Long idServicio) {
        try {
            servicioTuristicoService.deleteServicioTuristico(idServicio);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body("ServicioTuristico eliminado");
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al eliminar el servicioTuristico");
        }
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<ServicioTuristico>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(servicioTuristicoService.buscarServicioTuristicoPorNombre(nombre));
    }
}
