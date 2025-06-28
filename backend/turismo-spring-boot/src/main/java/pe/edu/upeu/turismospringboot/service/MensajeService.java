package pe.edu.upeu.turismospringboot.service;

import pe.edu.upeu.turismospringboot.model.dto.ChatResumenDto;
import pe.edu.upeu.turismospringboot.model.dto.MensajeDto;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;

import java.util.List;

public interface MensajeService {
    public List<MensajeDto> obtenerHistorialEntre(Usuario usuarioAutenticado, Long otroUsuarioId);
    public List<ChatResumenDto> obtenerChatsRecientes(Long usuarioId);
}