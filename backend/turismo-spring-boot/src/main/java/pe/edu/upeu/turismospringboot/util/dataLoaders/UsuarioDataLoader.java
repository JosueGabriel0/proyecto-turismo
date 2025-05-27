package pe.edu.upeu.turismospringboot.util.dataLoaders;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;
import pe.edu.upeu.turismospringboot.model.entity.Persona;
import pe.edu.upeu.turismospringboot.model.entity.Rol;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.model.enums.EstadoCuenta;
import pe.edu.upeu.turismospringboot.repository.EmprendimientoRepository;
import pe.edu.upeu.turismospringboot.repository.PersonaRepository;
import pe.edu.upeu.turismospringboot.repository.RolRepository;
import pe.edu.upeu.turismospringboot.repository.UsuarioRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Order(7)
@Component
@RequiredArgsConstructor
public class UsuarioDataLoader implements CommandLineRunner {

    private final UsuarioRepository usuarioRepository;
    private final RolRepository rolRepository;
    private final PersonaRepository personaRepository;
    private final PasswordEncoder passwordEncoder;
    private final EmprendimientoRepository emprendimientoRepository;

    @Override
    @Transactional
    public void run(String... args) {
        if (usuarioRepository.findByUsername("admin").isEmpty()) {

            // Crear roles si no existen (como antes)
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

            List<Emprendimiento> emprendimientos = emprendimientoRepository.findAll();

            // Crear persona para admin
            Persona personaAdmin = new Persona();
            personaAdmin.setNombres("Admin");
            personaAdmin.setApellidos("Principal");
            personaAdmin.setTipoDocumento("DNI");
            personaAdmin.setNumeroDocumento("12345678");
            personaAdmin.setTelefono("1234567890");
            personaAdmin.setDireccion("Jr. callefalsa");
            personaAdmin.setCorreoElectronico("admin@gmail.com");
            personaAdmin.setFotoPerfil("persona1.jpg");
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
            personaUsuario.setFotoPerfil("persona2.jpg");
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

            // Crear 7 emprendedores si hay suficientes emprendimientos
            for (int i = 0; i < Math.min(7, emprendimientos.size()); i++) {
                Emprendimiento emp = emprendimientos.get(i);

                Persona personaEmp = new Persona();
                personaEmp.setNombres("Emprendedor" + (i + 1));
                personaEmp.setApellidos("Apellido" + (i + 1));
                personaEmp.setTipoDocumento("DNI");
                personaEmp.setNumeroDocumento("1000000" + i);
                personaEmp.setTelefono("98765432" + i);
                personaEmp.setDireccion("Dirección " + (i + 1));
                personaEmp.setCorreoElectronico("emprendedor" + (i + 1) + "@gmail.com");
                personaEmp.setFotoPerfil("emprendedor" + (i + 1) + ".png");
                personaEmp.setFechaNacimiento(LocalDate.of(1988 - i, 1, 1));
                personaRepository.save(personaEmp);

                Usuario usuarioEmp = new Usuario();
                usuarioEmp.setUsername("emprendedor" + (i + 1));
                usuarioEmp.setPassword(passwordEncoder.encode("Password123!emprendedor" + (i + 1)));
                usuarioEmp.setRol(rolEmprendedor);
                usuarioEmp.setEmprendimiento(emp);
                usuarioEmp.setPersona(personaEmp);
                usuarioEmp.setEstado(EstadoCuenta.ACTIVO);
                usuarioEmp.setFechaCreacionUsuario(LocalDateTime.now());
                usuarioRepository.save(usuarioEmp);
            }

            System.out.println("Usuarios creados: admin, usuario, emprendedor1-7");
        } else {
            System.out.println("El usuario admin ya existe.");
        }
    }
}