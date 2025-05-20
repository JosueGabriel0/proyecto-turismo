package pe.edu.upeu.turismospringboot.controller.admin;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaCategoriaDto;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaCategoriaDtoPost;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaDto;
import pe.edu.upeu.turismospringboot.model.entity.FamiliaCategoria;
import pe.edu.upeu.turismospringboot.service.FamiliaCategoriaService;
import pe.edu.upeu.turismospringboot.service.impl.FamiliaCategoriaServiceImpl;

import java.util.List;

@RestController
@RequestMapping("/admin/familiaCategoria")
@RequiredArgsConstructor
public class FamiliaCategoriaController {

    private final FamiliaCategoriaService familiaCategoriaService;
    private final FamiliaCategoriaServiceImpl familiaCategoriaServiceImpl;

    @PostMapping
    public ResponseEntity<FamiliaCategoria> asociarCategoriaAFamilia(
            @RequestBody FamiliaCategoriaDtoPost dto
            ) {
        return ResponseEntity.ok(familiaCategoriaService.asociarCategoriaAFamilia(dto));
    }

    @GetMapping
    public ResponseEntity<List<FamiliaCategoriaDto>> listarRelaciones() {
        return ResponseEntity.ok(familiaCategoriaService.listarRelaciones());
    }

    @GetMapping("/familia/{idFamilia}")
    public ResponseEntity<List<FamiliaCategoriaDto>> obtenerFamiliaCategoriaPorIdFamilia(@PathVariable Long idFamilia) {
        return ResponseEntity.ok().body(familiaCategoriaService.obtenerFamiliaCategoriaPorIdFamilia(idFamilia));
    }

    @GetMapping("/categoria/{idCategoria}")
    public ResponseEntity<List<FamiliaCategoriaDto>> obtenerFamiliaCategoriaPorIdCategoria(@PathVariable Long idCategoria) {
        return ResponseEntity.ok().body(familiaCategoriaService.obtenerFamiliaCategoriaPorIdCategoria(idCategoria));
    }

    @DeleteMapping("/{idFamiliaCategoria}")
    public ResponseEntity<Void> eliminarRelacion(@PathVariable Long idFamiliaCategoria) {
        try{
            familiaCategoriaService.eliminarRelacion(idFamiliaCategoria);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.notFound().build();
        }
    }

}