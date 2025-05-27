package pe.edu.upeu.turismospringboot.util.dataLoaders;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import pe.edu.upeu.turismospringboot.model.entity.Familia;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;
import pe.edu.upeu.turismospringboot.repository.FamiliaRepository;
import pe.edu.upeu.turismospringboot.repository.LugarRepository;

import java.time.LocalDateTime;
import java.util.List;

@Order(3)
@Component
@RequiredArgsConstructor
public class FamiliasDataLoader implements CommandLineRunner {

    private final FamiliaRepository familiaRepository;
    private final LugarRepository lugarRepository;

    @Override
    public void run(String... args) {
        if (familiaRepository.count() == 0) {
            List<Lugar> lugares = lugarRepository.findAll();

            if (lugares.size() >= 2) {
                Lugar lugar1 = lugares.get(0);
                Lugar lugar2 = lugares.get(1);

                Familia familia1 = new Familia();
                familia1.setNombre("Guardianes del Valle");
                familia1.setDescripcion("Grupo protector de las tierras y leyendas de Lunaria.");
                familia1.setImagenUrl("familia1.jpg");
                familia1.setLugar(lugar1);
                familia1.setFechaCreacionFamilia(LocalDateTime.now());

                Familia familia2 = new Familia();
                familia2.setNombre("Susurradores del Eco");
                familia2.setDescripcion("Comunidad ancestral que interpreta los ecos de la isla.");
                familia2.setImagenUrl("familia2.jpg");
                familia2.setLugar(lugar2);
                familia2.setFechaCreacionFamilia(LocalDateTime.now());

                familiaRepository.saveAll(List.of(familia1, familia2));

                System.out.println(">>> Familias ficticias insertadas correctamente.");
            } else {
                System.out.println(">>> No hay suficientes lugares en la base de datos para asignar familias.");
            }
        }
    }
}