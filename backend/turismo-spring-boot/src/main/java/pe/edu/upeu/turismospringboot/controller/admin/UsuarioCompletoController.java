package pe.edu.upeu.turismospringboot.controller.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
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

    @PostMapping(consumes = {"multipart/form-data"})
    public ResponseEntity<Usuario> insertUsuarioCompleto(
            @RequestPart("usuario") String usuarioJson,
            @RequestPart(value = "file", required = false) MultipartFile file) {

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            UsuarioCompletoDto usuarioDto = objectMapper.readValue(usuarioJson, UsuarioCompletoDto.class);

            Usuario usuarioCreado = usuarioCompletoService.crearUsuarioCompleto(usuarioDto, file);

            return ResponseEntity.status(HttpStatus.CREATED).body(usuarioCreado);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/{idUsuario}")
    public ResponseEntity<Usuario> updateUsuarioCompleto(
            @PathVariable Long idUsuario,
            @RequestPart("usuario") String usuarioJson,
            @RequestPart(value = "file", required = false) MultipartFile file) {

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            UsuarioCompletoDto usuarioDto = objectMapper.readValue(usuarioJson, UsuarioCompletoDto.class);

            // Llamar al servicio para actualizar el usuario
            Usuario usuarioActualizado = usuarioCompletoService.actualizarUsuarioCompleto(idUsuario, usuarioDto, file);

            return ResponseEntity.ok(usuarioActualizado);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
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

    @GetMapping("/buscar")
    public ResponseEntity<List<Usuario>> buscarPorUsername(@RequestParam String username) {
        return ResponseEntity.ok(usuarioCompletoService.buscarUsuariosPorUsername(username));
    }
}
