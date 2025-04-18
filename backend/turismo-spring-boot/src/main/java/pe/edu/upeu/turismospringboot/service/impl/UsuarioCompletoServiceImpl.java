package pe.edu.upeu.turismospringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pe.edu.upeu.turismospringboot.model.dto.UsuarioCompletoDto;
import pe.edu.upeu.turismospringboot.model.entity.Persona;
import pe.edu.upeu.turismospringboot.model.entity.Rol;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.model.enums.EstadoCuenta;
import pe.edu.upeu.turismospringboot.repository.PersonaRepository;
import pe.edu.upeu.turismospringboot.repository.RolRepository;
import pe.edu.upeu.turismospringboot.repository.UsuarioRepository;
import pe.edu.upeu.turismospringboot.service.UsuarioCompletoService;

import java.util.List;

@Service
public class UsuarioCompletoServiceImpl implements UsuarioCompletoService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PersonaRepository personaRepository;

    @Autowired
    private RolRepository rolRepository;

    @Override
    public List<Usuario> listarUsuarioCompleto() {
        return usuarioRepository.findAll();
    }

    @Override
    public Usuario buscarUsuarioCompletoPorId(Long idUsuario) {
        return usuarioRepository.findById(idUsuario).orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
    }

    @Override
    public Usuario crearUsuarioCompleto(UsuarioCompletoDto usuarioCompleto) {
        Rol rol = rolRepository.findByNombre(usuarioCompleto.getNombreRol()).orElseThrow(() -> new RuntimeException("Rol no encontrado"));

        Persona personaCreada = new Persona();
        personaCreada.setNombres(usuarioCompleto.getNombres());
        personaCreada.setApellidos(usuarioCompleto.getApellidos());
        personaCreada.setTipoDocumento(usuarioCompleto.getTipoDocumento());
        personaCreada.setNumeroDocumento(usuarioCompleto.getNumeroDocumento());
        personaCreada.setTelefono(usuarioCompleto.getTelefono());
        personaCreada.setDireccion(usuarioCompleto.getDireccion());
        personaCreada.setCorreoElectronico(usuarioCompleto.getCorreoElectronico());
        personaCreada.setFotoPerfil(usuarioCompleto.getFotoPerfil());
        personaCreada.setFechaNacimiento(usuarioCompleto.getFechaNacimiento());
        personaRepository.save(personaCreada);

        Usuario usuario = new Usuario();
        usuario.setUsername(usuarioCompleto.getUsername());
        usuario.setPassword(usuarioCompleto.getPassword());
        try {
            EstadoCuenta estado = EstadoCuenta.valueOf(usuarioCompleto.getEstadoCuenta());
            usuario.setEstado(estado);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Estado de cuenta invalido: " + usuarioCompleto.getEstadoCuenta());
        }
        usuario.setRol(rol);
        usuario.setPersona(personaCreada);

        return usuarioRepository.save(usuario);
    }

    @Override
    public Usuario actualizarUsuarioCompleto(Long idUsuario, UsuarioCompletoDto usuarioCompleto){
        Usuario usuario = usuarioRepository.findById(idUsuario).orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
        usuario.setUsername(usuarioCompleto.getUsername());
        usuario.setPassword(usuarioCompleto.getPassword());
        try {
            EstadoCuenta estado = EstadoCuenta.valueOf(usuarioCompleto.getEstadoCuenta());
            usuario.setEstado(estado);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Estado de cuenta invalido: " + usuarioCompleto.getEstadoCuenta());
        }

        Persona persona = usuario.getPersona();
        persona.setNombres(usuarioCompleto.getNombres());
        persona.setApellidos(usuarioCompleto.getApellidos());
        persona.setTipoDocumento(usuarioCompleto.getTipoDocumento());
        persona.setNumeroDocumento(usuarioCompleto.getNumeroDocumento());
        persona.setTelefono(usuarioCompleto.getTelefono());
        persona.setDireccion(usuarioCompleto.getDireccion());
        persona.setCorreoElectronico(usuarioCompleto.getCorreoElectronico());
        persona.setFotoPerfil(usuarioCompleto.getFotoPerfil());
        persona.setFechaNacimiento(usuarioCompleto.getFechaNacimiento());

        Rol rolEncontrado = rolRepository.findByNombre(usuarioCompleto.getNombreRol()).orElseThrow(() -> new RuntimeException("Rol no encontrado"));
        usuario.setRol(rolEncontrado);

        return usuarioRepository.save(usuario);
    }

    @Override
    public void eliminarUsuarioCompleto(Long idUsuario) {
        usuarioRepository.deleteById(idUsuario);
    }
}
