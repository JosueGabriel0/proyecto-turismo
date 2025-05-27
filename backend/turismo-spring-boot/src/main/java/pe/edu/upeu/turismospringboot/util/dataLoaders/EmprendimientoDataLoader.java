package pe.edu.upeu.turismospringboot.util.dataLoaders;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;
import pe.edu.upeu.turismospringboot.model.entity.FamiliaCategoria;
import pe.edu.upeu.turismospringboot.repository.EmprendimientoRepository;
import pe.edu.upeu.turismospringboot.repository.FamiliaCategoriaRepository;

import java.time.LocalDateTime;
import java.util.List;

@Order(6)
@Component
@RequiredArgsConstructor
public class EmprendimientoDataLoader implements CommandLineRunner {

        private final EmprendimientoRepository emprendimientoRepository;
        private final FamiliaCategoriaRepository familiaCategoriaRepository;

        @Override
        public void run(String... args) {
                if (emprendimientoRepository.count() == 0) {
                        List<FamiliaCategoria> familiaCategorias = familiaCategoriaRepository.findAll();

                        if (familiaCategorias.size() < 7) {
                                System.out.println(">>> Se requieren al menos 7 registros en FamiliaCategoria para asociar a los emprendimientos.");
                                return;
                        }

                        Emprendimiento emp1 = new Emprendimiento();
                        emp1.setNombre("Hostal Estrella Andina");
                        emp1.setDescripcion("Alojamiento familiar con vista a las montañas de Lunaria.");
                        emp1.setImagenUrl("hotelE.jpg");
                        emp1.setLatitud(-13.5123);
                        emp1.setLongitud(-71.9821);
                        emp1.setFechaCreacionEmprendimiento(LocalDateTime.now());
                        emp1.setFamiliaCategoria(familiaCategorias.get(0));

                        Emprendimiento emp2 = new Emprendimiento();
                        emp2.setNombre("Sabores de Lunaria");
                        emp2.setDescripcion("Restaurante que fusiona cocina tradicional y contemporánea.");
                        emp2.setImagenUrl("restauranteE.jpg");
                        emp2.setLatitud(-13.5132);
                        emp2.setLongitud(-71.9800);
                        emp2.setFechaCreacionEmprendimiento(LocalDateTime.now());
                        emp2.setFamiliaCategoria(familiaCategorias.get(1));

                        Emprendimiento emp3 = new Emprendimiento();
                        emp3.setNombre("Manos de Barro");
                        emp3.setDescripcion("Taller de cerámica artesanal con técnicas ancestrales.");
                        emp3.setImagenUrl("artesaniaE.jpg");
                        emp3.setLatitud(-13.5100);
                        emp3.setLongitud(-71.9790);
                        emp3.setFechaCreacionEmprendimiento(LocalDateTime.now());
                        emp3.setFamiliaCategoria(familiaCategorias.get(2));

                        Emprendimiento emp4 = new Emprendimiento();
                        emp4.setNombre("Ciclotur Lunaria");
                        emp4.setDescripcion("Tours en bicicleta por rutas naturales y pueblos históricos.");
                        emp4.setImagenUrl("cyclingE.jpg");
                        emp4.setLatitud(-13.5200);
                        emp4.setLongitud(-71.9750);
                        emp4.setFechaCreacionEmprendimiento(LocalDateTime.now());
                        emp4.setFamiliaCategoria(familiaCategorias.get(3));

                        Emprendimiento emp5 = new Emprendimiento();
                        emp5.setNombre("Aventura Kayak");
                        emp5.setDescripcion("Recorridos en kayak por el río encantado de Lunaria.");
                        emp5.setImagenUrl("kayakE.jpg");
                        emp5.setLatitud(-13.5250);
                        emp5.setLongitud(-71.9700);
                        emp5.setFechaCreacionEmprendimiento(LocalDateTime.now());
                        emp5.setFamiliaCategoria(familiaCategorias.get(4));

                        Emprendimiento emp6 = new Emprendimiento();
                        emp6.setNombre("Museo Vivo Lunaria");
                        emp6.setDescripcion("Exposición interactiva sobre la historia y mitos de la región.");
                        emp6.setImagenUrl("culturaE.jpg");
                        emp6.setLatitud(-13.5180);
                        emp6.setLongitud(-71.9785);
                        emp6.setFechaCreacionEmprendimiento(LocalDateTime.now());
                        emp6.setFamiliaCategoria(familiaCategorias.get(5));

                        Emprendimiento emp7 = new Emprendimiento();
                        emp7.setNombre("Pack Aventurero");
                        emp7.setDescripcion("Hospedaje + actividades al aire libre en un solo paquete.");
                        emp7.setImagenUrl("paqueteE.png");
                        emp7.setLatitud(-13.5190);
                        emp7.setLongitud(-71.9760);
                        emp7.setFechaCreacionEmprendimiento(LocalDateTime.now());
                        emp7.setFamiliaCategoria(familiaCategorias.get(6));

                        emprendimientoRepository.saveAll(List.of(emp1, emp2, emp3, emp4, emp5, emp6, emp7));

                        System.out.println(">>> Emprendimientos insertados y asociados a FamiliaCategoria correctamente.");
                }
        }
}