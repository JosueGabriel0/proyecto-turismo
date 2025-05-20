package pe.edu.upeu.turismospringboot.controller.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaDto;
import pe.edu.upeu.turismospringboot.model.entity.Familia;
import pe.edu.upeu.turismospringboot.service.FamiliaService;

import java.util.List;

@Controller
@RequestMapping("/admin/familia")
public class FamiliaController {
    @Autowired
    private FamiliaService familiaService;

    @GetMapping
    public ResponseEntity<List<Familia>> obtenerFamilias() {
        return ResponseEntity.ok(familiaService.getFamilias());
    }

    @GetMapping("/{idFamilia}")
    public ResponseEntity<Familia> obtenerFamiliaPorId(@PathVariable Long idFamilia) {
        return ResponseEntity.ok(familiaService.getFamiliaById(idFamilia));
    }

    @PostMapping(consumes = {"multipart/form-data"})
    public ResponseEntity<Familia> guardarFamilia(
            @RequestPart(value = "familia") String familiaJson,
            @RequestPart(value = "file", required = false) MultipartFile file) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            FamiliaDto familiaDto = objectMapper.readValue(familiaJson, FamiliaDto.class);

            Familia familiaCreada = familiaService.postFamilia(familiaDto, file);
            return ResponseEntity.status(HttpStatus.CREATED).body(familiaCreada);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PutMapping(consumes = {"multipart/form-data"}, path = "/{idFamilia}")
    public ResponseEntity<Familia> actualizarFamilia(
            @PathVariable Long idFamilia,
            @RequestPart(value = "familia") String familiaJson,
            @RequestPart(value = "file", required = false) MultipartFile file) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            FamiliaDto familiaDto = objectMapper.readValue(familiaJson, FamiliaDto.class);

            Familia familiaActualizada = familiaService.putFamilia(idFamilia, familiaDto, file);
            return ResponseEntity.ok(familiaActualizada);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @DeleteMapping("/{idFamilia}")
    public ResponseEntity<String> eliminarFamilia(@PathVariable Long idFamilia) {
        try {
            familiaService.deleteFamilia(idFamilia);
            return ResponseEntity.ok("Familia eliminada con exito");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Familia>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(familiaService.buscarPorNombre(nombre));
    }
}
