package pe.edu.upeu.turismospringboot.controller.general;

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
@RequestMapping("/general/familia")
public class FamiliaControllerGeneral {
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

    @GetMapping("/buscar")
    public ResponseEntity<List<Familia>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(familiaService.buscarPorNombre(nombre));
    }
}