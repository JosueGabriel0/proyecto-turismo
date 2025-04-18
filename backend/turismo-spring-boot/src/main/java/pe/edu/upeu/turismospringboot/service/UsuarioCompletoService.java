package pe.edu.upeu.turismospringboot.service;

import pe.edu.upeu.turismospringboot.model.dto.UsuarioCompletoDto;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;

import java.util.List;

public interface UsuarioCompletoService {
    public List<Usuario> listarUsuarioCompleto();
    public Usuario buscarUsuarioCompletoPorId(Long idUsuario);
    public Usuario crearUsuarioCompleto(UsuarioCompletoDto usuarioCompleto);
    public Usuario actualizarUsuarioCompleto(Long idUsuario, UsuarioCompletoDto usuarioCompleto);
    public void eliminarUsuarioCompleto(Long idUsuario);
}
