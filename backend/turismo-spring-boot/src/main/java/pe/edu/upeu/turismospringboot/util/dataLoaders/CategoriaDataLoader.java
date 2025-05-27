package pe.edu.upeu.turismospringboot.util.dataLoaders;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import pe.edu.upeu.turismospringboot.model.entity.Categoria;
import pe.edu.upeu.turismospringboot.model.entity.Familia;
import pe.edu.upeu.turismospringboot.repository.CategoriaRepository;
import pe.edu.upeu.turismospringboot.repository.FamiliaRepository;

import java.time.LocalDateTime;
import java.util.List;

@Order(4)
@Component
@RequiredArgsConstructor
public class CategoriaDataLoader implements CommandLineRunner {

    private final CategoriaRepository categoriaRepository;
    private final FamiliaRepository familiaRepository;

    @Override
    public void run(String... args) {
        if (categoriaRepository.count() == 0) {

            Categoria cat1 = new Categoria();
            cat1.setNombre("Hotelería");
            cat1.setDescripcion("Alojamientos y hospedajes de Lunaria.");
            cat1.setImagenUrl("hoteleria.png");
            cat1.setFechaCreacionCategoria(LocalDateTime.now());

            Categoria cat2 = new Categoria();
            cat2.setNombre("Gastronomía");
            cat2.setDescripcion("Sabores autóctonos y cocina tradicional.");
            cat2.setImagenUrl("gastronomia.png");
            cat2.setFechaCreacionCategoria(LocalDateTime.now());

            Categoria cat3 = new Categoria();
            cat3.setNombre("Artesanía");
            cat3.setDescripcion("Arte y manualidades representativas del lugar.");
            cat3.setImagenUrl("artesania.png");
            cat3.setFechaCreacionCategoria(LocalDateTime.now());

            Categoria cat4 = new Categoria();
            cat4.setNombre("Cycling");
            cat4.setDescripcion("Rutas de ciclismo para todos los niveles.");
            cat4.setImagenUrl("cycling.png");
            cat4.setFechaCreacionCategoria(LocalDateTime.now());

            Categoria cat5 = new Categoria();
            cat5.setNombre("Kayak");
            cat5.setDescripcion("Explora los ríos y lagunas de Lunaria en kayak.");
            cat5.setImagenUrl("kayak.png");
            cat5.setFechaCreacionCategoria(LocalDateTime.now());

            Categoria cat6 = new Categoria();
            cat6.setNombre("Cultura");
            cat6.setDescripcion("Historia, costumbres y arte local.");
            cat6.setImagenUrl("cultura.png");
            cat6.setFechaCreacionCategoria(LocalDateTime.now());

            Categoria cat7 = new Categoria();
            cat7.setNombre("Paquetes");
            cat7.setDescripcion("Ofertas combinadas de actividades y alojamiento.");
            cat7.setImagenUrl("paquetes.png");
            cat7.setFechaCreacionCategoria(LocalDateTime.now());

            categoriaRepository.saveAll(List.of(cat1, cat2, cat3, cat4, cat5, cat6, cat7));

            System.out.println(">>> Categorías insertadas correctamente.");
        }
    }
}