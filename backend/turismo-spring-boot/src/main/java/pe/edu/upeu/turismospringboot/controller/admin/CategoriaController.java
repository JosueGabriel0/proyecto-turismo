package pe.edu.upeu.turismospringboot.controller.admin;

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
@RequestMapping("/admin/categoria")
public class CategoriaController {
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

    @PostMapping
    public ResponseEntity<Categoria> guardarCategoria(
            @RequestPart(value = "categoria") String categoriaJson,
            @RequestPart(value = "file", required = false) MultipartFile file
    ) {
       try {
           ObjectMapper objectMapper = new ObjectMapper();
           CategoriaDto categoriaDto = objectMapper.readValue(categoriaJson, CategoriaDto.class);

           return ResponseEntity.status(HttpStatus.CREATED).body(categoriaService.postCategoria(categoriaDto, file));
       } catch (Exception e) {
           e.printStackTrace();
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
       }
    }

    @PutMapping("/{idCategoria}")
    public ResponseEntity<Categoria> actualizarCategoria(
            @PathVariable Long idCategoria,
            @RequestPart(value = "categoria") String categoriaJson,
            @RequestPart(value = "file", required = false) MultipartFile file
    ){
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            CategoriaDto categoriaDto = objectMapper.readValue(categoriaJson, CategoriaDto.class);

            return ResponseEntity.ok().body(categoriaService.putCategoria(idCategoria, categoriaDto, file));
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @DeleteMapping("/{idCategoria}")
    public ResponseEntity<String> eliminarCategoria(@PathVariable Long idCategoria) {
        try {
            categoriaService.deleteCategoria(idCategoria);
            return ResponseEntity.ok().body("Categoria eliminado exitosamente");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al eliminar el categoria: "+e.getMessage());
        }
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Categoria>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(categoriaService.buscarPorNombre(nombre));
    }
}
