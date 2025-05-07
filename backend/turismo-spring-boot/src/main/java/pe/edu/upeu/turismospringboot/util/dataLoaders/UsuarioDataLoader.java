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

            // Crear roles si no existen
            Rol rolAdmin = rolRepository.findByNombre("ROLE_ADMIN").orElseGet(() -> {
                Rol nuevoRol = new Rol();
                nuevoRol.setNombre("ROLE_ADMIN");
                return rolRepository.save(nuevoRol);
            });

            Rol rolUsuario = rolRepository.findByNombre("ROLE_USUARIO").orElseGet(() -> {
                Rol nuevoRol = new Rol();
                nuevoRol.setNombre("ROLE_USUARIO");
                return rolRepository.save(nuevoRol);
            });

            Rol rolEmprendedor = rolRepository.findByNombre("ROLE_EMPRENDEDOR").orElseGet(() -> {
                Rol nuevoRol = new Rol();
                nuevoRol.setNombre("ROLE_EMPRENDEDOR");
                return rolRepository.save(nuevoRol);
            });

            // Crear persona para admin
            Persona personaAdmin = new Persona();
            personaAdmin.setNombres("Admin");
            personaAdmin.setApellidos("Principal");
            personaAdmin.setTipoDocumento("DNI");
            personaAdmin.setNumeroDocumento("12345678");
            personaAdmin.setTelefono("1234567890");
            personaAdmin.setDireccion("Jr. callefalsa");
            personaAdmin.setCorreoElectronico("admin@gmail.com");
            personaAdmin.setFechaNacimiento(LocalDate.of(1990, 1, 1));
            personaRepository.save(personaAdmin);

            // Crear usuario admin
            Usuario usuarioAdmin = new Usuario();
            usuarioAdmin.setUsername("admin");
            usuarioAdmin.setPassword(passwordEncoder.encode("Password123!admin"));
            usuarioAdmin.setRol(rolAdmin);
            usuarioAdmin.setPersona(personaAdmin);
            usuarioAdmin.setEstado(EstadoCuenta.ACTIVO);
            usuarioAdmin.setFechaCreacionUsuario(LocalDateTime.now());
            usuarioRepository.save(usuarioAdmin);

            // Crear persona para usuario
            Persona personaUsuario = new Persona();
            personaUsuario.setNombres("Usuario");
            personaUsuario.setApellidos("Principal");
            personaUsuario.setTipoDocumento("DNI");
            personaUsuario.setNumeroDocumento("87654321");
            personaUsuario.setTelefono("1234567891");
            personaUsuario.setDireccion("Av. ejemplo");
            personaUsuario.setCorreoElectronico("usuario@gmail.com");
            personaUsuario.setFechaNacimiento(LocalDate.of(1995, 2, 2));
            personaRepository.save(personaUsuario);

            // Crear usuario
            Usuario usuario = new Usuario();
            usuario.setUsername("usuario");
            usuario.setPassword(passwordEncoder.encode("Password123!usuario"));
            usuario.setRol(rolUsuario);
            usuario.setPersona(personaUsuario);
            usuario.setEstado(EstadoCuenta.ACTIVO);
            usuario.setFechaCreacionUsuario(LocalDateTime.now());
            usuarioRepository.save(usuario);

            // Crear persona para emprendedor
            Persona personaEmprendedor = new Persona();
            personaEmprendedor.setNombres("Emprendedor");
            personaEmprendedor.setApellidos("Principal");
            personaEmprendedor.setTipoDocumento("DNI");
            personaEmprendedor.setNumeroDocumento("11223344");
            personaEmprendedor.setTelefono("1234567892");
            personaEmprendedor.setDireccion("Calle emprendimiento");
            personaEmprendedor.setCorreoElectronico("emprendedor@gmail.com");
            personaEmprendedor.setFechaNacimiento(LocalDate.of(1988, 3, 3));
            personaRepository.save(personaEmprendedor);

            // Crear usuario
            Usuario usuarioEmprendedor = new Usuario();
            usuarioEmprendedor.setUsername("emprendedor");
            usuarioEmprendedor.setPassword(passwordEncoder.encode("Password123!emprendedor"));
            usuarioEmprendedor.setRol(rolEmprendedor);
            usuarioEmprendedor.setPersona(personaEmprendedor);
            usuarioEmprendedor.setEstado(EstadoCuenta.ACTIVO);
            usuarioEmprendedor.setFechaCreacionUsuario(LocalDateTime.now());
            usuarioRepository.save(usuarioEmprendedor);

            System.out.println("Usuario admin creado con éxito.");
            System.out.println("Usuario usuario creado con éxito.");
            System.out.println("Usuario emprendedor creado con éxito.");

        } else {
            System.out.println("Usuario admin ya existe.");
        }
    }
}