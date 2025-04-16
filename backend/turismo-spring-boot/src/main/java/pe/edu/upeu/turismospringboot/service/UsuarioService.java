package pe.edu.upeu.turismospringboot.service;

import pe.edu.upeu.turismospringboot.model.entity.Usuario;

import java.util.List;

public interface UsuarioService {

    public List<Usuario> listarUsuarios();
    public Usuario buscarUsuario(Long id);
    public Usuario guardarUsuario(Usuario usuario);
    public Usuario actualizarUsuario(Usuario usuario);
    public void eliminarUsuario(Long id);
}
