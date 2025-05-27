package pe.edu.upeu.turismospringboot.controller.general;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.turismospringboot.model.entity.Familia;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;
import pe.edu.upeu.turismospringboot.service.LugarService;

import java.util.List;

@RestController
@RequestMapping("/general/lugar")
public class LugarControllerGeneral {
    @Autowired
    private LugarService lugarService;

    @GetMapping
    public ResponseEntity<List<Lugar>> listarLugares(){
        return ResponseEntity.ok(lugarService.getlugares());
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Lugar>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(lugarService.buscarLugarPorNombre(nombre));
    }


    @GetMapping("/{idLugar}/familias")
    public ResponseEntity<List<Familia>> obtenerFamiliasPorLugar(
            @PathVariable Long idLugar,
            @RequestParam(required = false) String nombre) {

        List<Familia> familias = lugarService.getFamiliasPorLugar(idLugar, nombre);
        return ResponseEntity.ok(familias);
    }
}
