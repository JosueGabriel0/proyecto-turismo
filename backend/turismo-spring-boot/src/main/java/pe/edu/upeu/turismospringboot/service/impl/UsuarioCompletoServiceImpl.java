package pe.edu.upeu.turismospringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.UsuarioCompletoDto;
import pe.edu.upeu.turismospringboot.model.entity.Persona;
import pe.edu.upeu.turismospringboot.model.entity.Rol;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.model.enums.EstadoCuenta;
import pe.edu.upeu.turismospringboot.repository.PersonaRepository;
import pe.edu.upeu.turismospringboot.repository.RolRepository;
import pe.edu.upeu.turismospringboot.repository.UsuarioRepository;
import pe.edu.upeu.turismospringboot.service.UsuarioCompletoService;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class UsuarioCompletoServiceImpl implements UsuarioCompletoService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PersonaRepository personaRepository;

    @Autowired
    private RolRepository rolRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public List<Usuario> listarUsuarioCompleto() {
        return usuarioRepository.findAll();
    }

    @Override
    public Usuario buscarUsuarioCompletoPorId(Long idUsuario) {
        return usuarioRepository.findById(idUsuario).orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
    }

    @Override
    public Usuario crearUsuarioCompleto(UsuarioCompletoDto usuarioCompleto, MultipartFile file) {
        if (file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            usuarioCompleto.setFotoPerfil(fileName);
        }

        Rol rol = rolRepository.findByNombre(usuarioCompleto.getNombreRol())
                .orElseThrow(() -> new RuntimeException("Rol no encontrado"));

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
        usuario.setPassword(passwordEncoder.encode(usuarioCompleto.getPassword()));
        EstadoCuenta estado = EstadoCuenta.valueOf(usuarioCompleto.getEstadoCuenta());
        usuario.setEstado(estado);
        usuario.setRol(rol);
        usuario.setPersona(personaCreada);

        return usuarioRepository.save(usuario);
    }

    @Override
    public Usuario actualizarUsuarioCompleto(Long idUsuario, UsuarioCompletoDto usuarioCompleto, MultipartFile file) {
        // Buscar el usuario existente
        Usuario usuario = usuarioRepository.findById(idUsuario)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        // Si se proporciona un archivo de imagen, se guarda y se actualiza el fotoPerfil
        if (file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            usuarioCompleto.setFotoPerfil(fileName);
        }

        // Actualizar la entidad Persona asociada
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

        // Guardar los cambios en Persona
        personaRepository.save(persona);

        // Actualizar el rol del usuario
        Rol rolEncontrado = rolRepository.findByNombre(usuarioCompleto.getNombreRol())
                .orElseThrow(() -> new RuntimeException("Rol no encontrado"));
        usuario.setRol(rolEncontrado);

        // Actualizar los campos del usuario
        usuario.setUsername(usuarioCompleto.getUsername());
        usuario.setPassword(passwordEncoder.encode(usuarioCompleto.getPassword()));

        // Actualizar el estado de la cuenta
        try {
            EstadoCuenta estado = EstadoCuenta.valueOf(usuarioCompleto.getEstadoCuenta());
            usuario.setEstado(estado);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Estado de cuenta inválido: " + usuarioCompleto.getEstadoCuenta());
        }

        // Guardar el usuario actualizado
        return usuarioRepository.save(usuario);
    }

    @Override
    public void eliminarUsuarioCompleto(Long idUsuario) {
        usuarioRepository.deleteById(idUsuario);
    }

    private static final String UPLOAD_DIR = System.getProperty("user.dir") + "/upload/";
    private String saveFile(MultipartFile file) {
        try {
            File uploadPath = new File(UPLOAD_DIR);
            if (!uploadPath.exists()) {
                uploadPath.mkdirs();
            }
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File destinationFile = new File(uploadPath, fileName);
            file.transferTo(destinationFile);
            return fileName;
        } catch (IOException e) {
            throw new RuntimeException("Error al guardar la imagen", e);
        }
    }
}
