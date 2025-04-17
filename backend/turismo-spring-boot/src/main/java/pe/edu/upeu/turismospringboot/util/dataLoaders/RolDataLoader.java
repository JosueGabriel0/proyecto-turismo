package pe.edu.upeu.turismospringboot.util.dataLoaders;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import pe.edu.upeu.turismospringboot.model.entity.Rol;
import pe.edu.upeu.turismospringboot.repository.RolRepository;

@Component
@RequiredArgsConstructor
public class RolDataLoader implements CommandLineRunner {

    private final RolRepository rolRepository;

    @Override
    @Transactional
    public void run(String... args) {
        crearRolSiNoExiste("ADMIN");
        crearRolSiNoExiste("USUARIO");
    }

    private void crearRolSiNoExiste(String nombreRol) {
        rolRepository.findByNombre(nombreRol).orElseGet(() -> {
            Rol nuevoRol = new Rol();
            nuevoRol.setNombre(nombreRol);
            rolRepository.save(nuevoRol);
            System.out.println("Rol '" + nombreRol + "' creado.");
            return nuevoRol;
        });
    }
}