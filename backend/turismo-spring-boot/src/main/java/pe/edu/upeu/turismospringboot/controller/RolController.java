package pe.edu.upeu.turismospringboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.turismospringboot.model.entity.Rol;
import pe.edu.upeu.turismospringboot.service.RolService;

import java.util.List;

@RestController
@RequestMapping("/rol")
public class RolController {
    @Autowired
    private RolService rolService;

    @GetMapping
    public ResponseEntity<List<Rol>> listarRoles(){
        return ResponseEntity.ok(rolService.listarRoles());
    }

    @GetMapping("/{idRol}")
    public ResponseEntity<Rol> findById(@PathVariable Long idRol){
        return ResponseEntity.ok(rolService.obtenerRolPorId(idRol));
    }

    @PostMapping
    public ResponseEntity<Rol> guardarRol(@RequestBody Rol rol){
        return ResponseEntity.ok(rolService.guardarRol(rol));
    }

    @PutMapping("/{idRol}")
    public ResponseEntity<Rol> actualizarRol(@PathVariable Long idRol, @RequestBody Rol rol){
        rol.setIdRol(idRol);
        return ResponseEntity.ok(rolService.actualizarRol(rol));
    }

    @DeleteMapping("/{idRol}")
    public ResponseEntity<String> eliminarRol(@PathVariable Long idRol){
        try {
            rolService.eliminarRolPorId(idRol);
            return ResponseEntity.ok("Rol eliminado exitosamente");
        }catch (Exception e){
            return ResponseEntity.badRequest().body("Error al eliminar el rol");
        }
    }
}
