package pe.edu.upeu.turismospringboot.util.dataLoaders;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import pe.edu.upeu.turismospringboot.model.entity.Categoria;
import pe.edu.upeu.turismospringboot.model.entity.Familia;
import pe.edu.upeu.turismospringboot.model.entity.FamiliaCategoria;
import pe.edu.upeu.turismospringboot.repository.CategoriaRepository;
import pe.edu.upeu.turismospringboot.repository.FamiliaCategoriaRepository;
import pe.edu.upeu.turismospringboot.repository.FamiliaRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Order(5)
@Component
@RequiredArgsConstructor
public class FamiliaCategoriaDataLoader implements CommandLineRunner {

    private final FamiliaCategoriaRepository familiaCategoriaRepository;
    private final FamiliaRepository familiaRepository;
    private final CategoriaRepository categoriaRepository;

    @Override
    public void run(String... args) {
        if (familiaCategoriaRepository.count() == 0) {
            List<Familia> familias = familiaRepository.findAll();
            List<Categoria> categorias = categoriaRepository.findAll();

            if (familias.size() >= 2 && categorias.size() >= 7) {
                Familia familia1 = familias.get(0);
                Familia familia2 = familias.get(1);

                List<FamiliaCategoria> relaciones = new ArrayList<>();

                // Familia 1 con las 4 primeras categorías
                for (int i = 0; i < 4; i++) {
                    FamiliaCategoria fc = new FamiliaCategoria();
                    fc.setFamilia(familia1);
                    fc.setCategoria(categorias.get(i));
                    fc.setFechaCreacionFamiliaCategoria(LocalDateTime.now());
                    relaciones.add(fc);
                }

                // Familia 2 con las 3 siguientes categorías
                for (int i = 4; i < 7; i++) {
                    FamiliaCategoria fc = new FamiliaCategoria();
                    fc.setFamilia(familia2);
                    fc.setCategoria(categorias.get(i));
                    fc.setFechaCreacionFamiliaCategoria(LocalDateTime.now());
                    relaciones.add(fc);
                }

                familiaCategoriaRepository.saveAll(relaciones);
                System.out.println(">>> Relaciones FamiliaCategoria insertadas correctamente.");
            } else {
                System.out.println(">>> Se requieren al menos 2 familias y 7 categorías en la base de datos.");
            }
        }
    }
}