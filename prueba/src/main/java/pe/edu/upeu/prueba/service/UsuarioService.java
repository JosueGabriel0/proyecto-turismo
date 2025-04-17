package pe.edu.upeu.prueba.service;

import pe.edu.upeu.prueba.model.entity.Usuario;

import java.util.List;

public interface UsuarioService {

    public List<Usuario> listarUsuarios();
    public Usuario buscarUsuario(Long idUsuario);
    public Usuario guardarUsuario(Usuario usuario);
    public Usuario actualizarUsuario(Usuario usuario);
    public void eliminarUsuario(Long idUsuario);
}
