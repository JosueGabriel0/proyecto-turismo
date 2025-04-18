package pe.edu.upeu.turismospringboot.util.dataLoaders;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import pe.edu.upeu.turismospringboot.model.entity.Persona;
import pe.edu.upeu.turismospringboot.model.entity.Rol;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.model.enums.EstadoCuenta;
import pe.edu.upeu.turismospringboot.repository.PersonaRepository;
import pe.edu.upeu.turismospringboot.repository.RolRepository;
import pe.edu.upeu.turismospringboot.repository.UsuarioRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
public class UsuarioDataLoader implements CommandLineRunner {

    private final UsuarioRepository usuarioRepository;
    private final RolRepository rolRepository;
    private final PersonaRepository personaRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    @Transactional
    public void run(String... args) {
        if (usuarioRepository.findByUsername("admin").isEmpty()) {

            // Crear rol si no existe
            Rol rolAdmin = rolRepository.findByNombre("ROLE_ADMIN").orElseGet(() -> {
                Rol nuevoRol = new Rol();
                nuevoRol.setNombre("ROLE_ADMIN");
                return rolRepository.save(nuevoRol);
            });

            // Crear persona
            Persona persona = new Persona();
            persona.setNombres("Admin");
            persona.setApellidos("Principal");
            persona.setTipoDocumento("DNI");
            persona.setNumeroDocumento("12345678");
            persona.setTelefono("1234567890");
            persona.setDireccion("Jr. callefalsa");
            persona.setCorreoElectronico("usuario@gmail.com");
            persona.setFechaNacimiento(LocalDate.of(1990, 1, 1));
            personaRepository.save(persona);

            // Crear usuario
            Usuario usuario = new Usuario();
            usuario.setUsername("admin");
            usuario.setPassword(passwordEncoder.encode("123456")); // clave encriptada
            usuario.setRol(rolAdmin);
            usuario.setPersona(persona);
            usuario.setEstado(EstadoCuenta.ACTIVO);
            usuario.setFechaCreacionUsuario(LocalDateTime.now());

            usuarioRepository.save(usuario);

            System.out.println("Usuario admin creado con éxito.");
        } else {
            System.out.println("Usuario admin ya existe.");
        }
    }
}
