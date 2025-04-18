package pe.edu.upeu.turismospringboot.controller;

import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.turismospringboot.model.dto.UsuarioCompletoDto;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.service.UsuarioCompletoService;

import java.util.List;

@RestController
@RequestMapping("/admin/usuarioCompleto")
public class UsuarioCompletoController {
    @Autowired
    private UsuarioCompletoService usuarioCompletoService;

    @GetMapping
    public ResponseEntity<List<Usuario>> getUsuarioCompleto() {
        return ResponseEntity.ok(usuarioCompletoService.listarUsuarioCompleto());
    }

    @GetMapping("/{idUsuario}")
    public ResponseEntity<Usuario> getUsuarioCompletoById(@PathVariable Long idUsuario) {
        return ResponseEntity.ok(usuarioCompletoService.buscarUsuarioCompletoPorId(idUsuario));
    }

    @PostMapping
    public ResponseEntity<Usuario> insertUsuarioCompleto(@RequestBody UsuarioCompletoDto usuario) {
        return ResponseEntity.status(HttpStatus.CREATED).body(usuarioCompletoService.crearUsuarioCompleto(usuario));
    }

    @PutMapping("/{idUsuario}")
    public ResponseEntity<Usuario> updateUsuarioCompleto(@PathVariable Long idUsuario, @RequestBody UsuarioCompletoDto usuario) {
        return ResponseEntity.ok(usuarioCompletoService.actualizarUsuarioCompleto(idUsuario, usuario));
    }

    @DeleteMapping("/{idUsuario}")
    public ResponseEntity<String> deleteUsuarioCompleto(@PathVariable Long idUsuario) {
        try {
            usuarioCompletoService.eliminarUsuarioCompleto(idUsuario);
            return ResponseEntity.ok("Usuario eliminado correctamente");
        } catch (EntityNotFoundException e) { // O cualquier otra excepción relacionada con la búsqueda
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuario no encontrado");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al eliminar usuario");
        }
    }
}
