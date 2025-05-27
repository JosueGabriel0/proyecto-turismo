package pe.edu.upeu.turismospringboot.controller.general;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.CategoriaDto;
import pe.edu.upeu.turismospringboot.model.entity.Categoria;
import pe.edu.upeu.turismospringboot.service.CategoriaService;

import java.util.List;

@RestController
@RequestMapping("/general/categoria")
public class CategoriaControllerGeneral {
    @Autowired
    private CategoriaService categoriaService;

    @GetMapping
    public ResponseEntity<List<Categoria>> obtenerCategorias() {
        return ResponseEntity.ok().body(categoriaService.getCategorias());
    }

    @GetMapping("/{idCategoria}")
    public ResponseEntity<Categoria> obtenerCategoriaPorId(@PathVariable Long idCategoria) {
        return ResponseEntity.ok().body(categoriaService.getCategoriaById(idCategoria));
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Categoria>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(categoriaService.buscarPorNombre(nombre));
    }
}