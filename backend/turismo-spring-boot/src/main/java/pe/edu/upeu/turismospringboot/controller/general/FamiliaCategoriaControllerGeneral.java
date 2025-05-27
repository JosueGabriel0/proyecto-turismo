package pe.edu.upeu.turismospringboot.controller.general;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaCategoriaDto;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaCategoriaDtoPost;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaDto;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;
import pe.edu.upeu.turismospringboot.model.entity.Familia;
import pe.edu.upeu.turismospringboot.model.entity.FamiliaCategoria;
import pe.edu.upeu.turismospringboot.service.FamiliaCategoriaService;
import pe.edu.upeu.turismospringboot.service.impl.FamiliaCategoriaServiceImpl;

import java.util.List;

@RestController
@RequestMapping("/general/familiaCategoria")
@RequiredArgsConstructor
public class FamiliaCategoriaControllerGeneral {

    private final FamiliaCategoriaService familiaCategoriaService;
    private final FamiliaCategoriaServiceImpl familiaCategoriaServiceImpl;

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

    @GetMapping("/{idFamiliaCategoria}/emprendimientos")
    public ResponseEntity<List<Emprendimiento>> obtenerEmprendimientosPorFamiliaCategoria(
            @PathVariable Long idFamiliaCategoria,
            @RequestParam(required = false) String nombre) {

        List<Emprendimiento> emprendimientos = familiaCategoriaService.getEmprendimientosPorFamiliaCategoria(idFamiliaCategoria, nombre);
        return ResponseEntity.ok(emprendimientos);
    }
}