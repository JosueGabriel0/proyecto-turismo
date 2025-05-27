package pe.edu.upeu.turismospringboot.controller.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.LugarDto;
import pe.edu.upeu.turismospringboot.model.entity.Familia;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;
import pe.edu.upeu.turismospringboot.service.LugarService;

import java.util.List;

@RestController
@RequestMapping("/admin/lugar")
public class LugarController {

    @Autowired
    private LugarService lugarService;

    @GetMapping
    public ResponseEntity<List<Lugar>> listarLugar() {
        return ResponseEntity.ok(lugarService.getlugares());
    }

    @GetMapping("/{idLugar}")
    public ResponseEntity<Lugar> buscarLugarPorId(@PathVariable Long idLugar) {
        return ResponseEntity.ok(lugarService.getLugarById(idLugar));
    }

    @PostMapping(consumes = {"multipart/form-data"})
    public ResponseEntity<Lugar> crearLugar(
            @RequestPart("lugar") String lugarJson,
            @RequestPart(value = "file", required = false) MultipartFile file) {
        try{
            ObjectMapper objectMapper = new ObjectMapper();
            LugarDto lugarDto = objectMapper.readValue(lugarJson, LugarDto.class);

            Lugar lugarCreado = lugarService.postLugar(lugarDto, file);
            return ResponseEntity.status(HttpStatus.CREATED).body(lugarCreado);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/{idLugar}")
    public ResponseEntity<Lugar> actualizarLugar(
            @PathVariable Long idLugar,
            @RequestPart("lugar") String lugarJson,
            @RequestPart(value = "file", required = false) MultipartFile file) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            LugarDto lugarDto = objectMapper.readValue(lugarJson, LugarDto.class);

            Lugar lugarActualizado = lugarService.putLugar(idLugar, lugarDto, file);
            return ResponseEntity.ok(lugarActualizado);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @DeleteMapping("/{idLugar}")
    public ResponseEntity<String> eliminarLugar(@PathVariable Long idLugar) {
        try {
            lugarService.deleteLugar(idLugar);
            return ResponseEntity.ok("Lugar eliminado");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Lugar>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(lugarService.buscarLugarPorNombre(nombre));
    }
}
