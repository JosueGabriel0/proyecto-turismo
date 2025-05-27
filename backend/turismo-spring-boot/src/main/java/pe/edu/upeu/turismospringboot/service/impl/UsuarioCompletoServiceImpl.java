package pe.edu.upeu.turismospringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.UsuarioCompletoDto;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;
import pe.edu.upeu.turismospringboot.model.entity.Persona;
import pe.edu.upeu.turismospringboot.model.entity.Rol;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.model.enums.EstadoCuenta;
import pe.edu.upeu.turismospringboot.repository.EmprendimientoRepository;
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
    private EmprendimientoRepository emprendimientoRepository;

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

        if(usuarioCompleto.getNombreEmprendimiento() != null) {
            Emprendimiento emprendimiento = emprendimientoRepository.findByNombre(usuarioCompleto.getNombreEmprendimiento())
                    .orElseThrow(() -> new RuntimeException("Emprendimiento no encontrado"));
            usuario.setEmprendimiento(emprendimiento);
        }

        return usuarioRepository.save(usuario);
    }

    @Override
    public Usuario actualizarUsuarioCompleto(Long idUsuario, UsuarioCompletoDto usuarioCompleto, MultipartFile file) {
        Usuario usuario = usuarioRepository.findById(idUsuario)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        Persona persona = usuario.getPersona();

        // Si se proporciona un archivo nuevo, lo guardamos y actualizamos la foto
        if (file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            persona.setFotoPerfil(fileName);
        } else {
            // Si no se envió una nueva imagen, conservamos la existente
            usuarioCompleto.setFotoPerfil(persona.getFotoPerfil());
        }

        // Actualizar el resto de campos
        persona.setNombres(usuarioCompleto.getNombres());
        persona.setApellidos(usuarioCompleto.getApellidos());
        persona.setTipoDocumento(usuarioCompleto.getTipoDocumento());
        persona.setNumeroDocumento(usuarioCompleto.getNumeroDocumento());
        persona.setTelefono(usuarioCompleto.getTelefono());
        persona.setDireccion(usuarioCompleto.getDireccion());
        persona.setCorreoElectronico(usuarioCompleto.getCorreoElectronico());
        persona.setFechaNacimiento(usuarioCompleto.getFechaNacimiento());

        personaRepository.save(persona);

        Rol rolEncontrado = rolRepository.findByNombre(usuarioCompleto.getNombreRol())
                .orElseThrow(() -> new RuntimeException("Rol no encontrado"));
        usuario.setRol(rolEncontrado);

        if (usuarioCompleto.getNombreEmprendimiento() != null) {
            Emprendimiento emprendimiento = emprendimientoRepository.findByNombre(usuarioCompleto.getNombreEmprendimiento())
                    .orElseThrow(() -> new RuntimeException("Emprendimiento no encontrado"));
            usuario.setEmprendimiento(emprendimiento);
        }

        usuario.setUsername(usuarioCompleto.getUsername());
        String nuevaPassword = usuarioCompleto.getPassword();

        if (nuevaPassword != null && !nuevaPassword.isBlank()) {
            // Solo actualiza si la nueva contraseña no es igual a la actual
            if (!passwordEncoder.matches(nuevaPassword, usuario.getPassword())) {
                usuario.setPassword(passwordEncoder.encode(nuevaPassword));
            }
        }


        EstadoCuenta estado = EstadoCuenta.valueOf(usuarioCompleto.getEstadoCuenta());
        usuario.setEstado(estado);

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

    @Override
    public List<Usuario> buscarUsuariosPorUsername(String username) {
        return usuarioRepository.buscarPorUsername(username);
    }
}
