package pe.edu.upeu.turismospringboot.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.turismospringboot.model.dto.ChatResumenDto;
import pe.edu.upeu.turismospringboot.model.dto.MensajeDto;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.service.MensajeService;

import java.util.List;

@RestController
@RequestMapping("/admin/mensajes")
public class MensajeAdminController {

    @Autowired
    private MensajeService mensajeService;

    @GetMapping("/historial")
    public ResponseEntity<List<MensajeDto>> obtenerHistorial(
            @RequestParam Long usuarioId,
            @AuthenticationPrincipal Usuario usuarioAutenticado) {

        List<MensajeDto> historial = mensajeService.obtenerHistorialEntre(usuarioAutenticado, usuarioId);
        return ResponseEntity.ok(historial);
    }

    @GetMapping("/recientes")
    public ResponseEntity<List<ChatResumenDto>> obtenerChatsRecientes(
            @AuthenticationPrincipal Usuario usuarioAutenticado) {

        List<ChatResumenDto> chats = mensajeService.obtenerChatsRecientes(usuarioAutenticado.getIdUsuario());
        return ResponseEntity.ok(chats);
    }
}