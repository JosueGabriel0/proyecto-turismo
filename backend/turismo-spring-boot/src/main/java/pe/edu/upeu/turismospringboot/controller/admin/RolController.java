package pe.edu.upeu.turismospringboot.controller.admin;

import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.turismospringboot.model.dto.RolDto;
import pe.edu.upeu.turismospringboot.model.entity.Rol;
import pe.edu.upeu.turismospringboot.service.RolService;

import java.util.List;

@RestController
@RequestMapping("/admin/rol")
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
    public ResponseEntity<Rol> guardarRol(@RequestBody RolDto rolDto){
        return ResponseEntity.ok(rolService.guardarRol(rolDto));
    }

    @PutMapping("/{idRol}")
    public ResponseEntity<Rol> actualizarRol(@PathVariable Long idRol, @RequestBody RolDto rolDto){
        return ResponseEntity.ok(rolService.actualizarRol(idRol, rolDto));
    }

    @DeleteMapping("/{idRol}")
    public ResponseEntity<String> eliminarRol(@PathVariable Long idRol){
        try {
            rolService.eliminarRolPorId(idRol);
            return ResponseEntity.ok("Rol eliminado exitosamente");
        }catch (EntityNotFoundException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Rol no encontrado");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al eliminar el rol");
        }
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Rol>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(rolService.buscarRolesPorNombre(nombre));
    }
}
