package pe.edu.upeu.turismospringboot.util.dataLoaders;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;
import pe.edu.upeu.turismospringboot.repository.LugarRepository;

import java.time.LocalDateTime;
import java.util.List;

@Order(2)
@Component
@RequiredArgsConstructor
public class LugaresDataLoader {

    private final LugarRepository lugarRepository;

    @PostConstruct
    public void cargarDatosIniciales() {
        if (lugarRepository.count() == 0) {
            Lugar lugar1 = new Lugar();
            lugar1.setNombre("Valle Escondido de Lunaria");
            lugar1.setDescripcion("Un valle místico oculto entre montañas iluminadas por bioluminiscencia natural.");
            lugar1.setDireccion("Sendero de la Niebla Azul");
            lugar1.setCiudad("Lunaria");
            lugar1.setProvincia("Nébulas Altas");
            lugar1.setPais("Térra Fantástica");
            lugar1.setLatitud(-34.1234);
            lugar1.setLongitud(12.5678);
            lugar1.setImagenUrl("lugar1.jpg");
            lugar1.setFechaCreacionLugar(LocalDateTime.now());

            Lugar lugar2 = new Lugar();
            lugar2.setNombre("Isla de los Ecos Susurrantes");
            lugar2.setDescripcion("Una isla legendaria donde los ecos cuentan historias antiguas a quienes saben escuchar.");
            lugar2.setDireccion("Costa del Silencio Eterno");
            lugar2.setCiudad("Echonia");
            lugar2.setProvincia("Archipiélago Murmullo");
            lugar2.setPais("Reino de la Bruma");
            lugar2.setLatitud(5.4321);
            lugar2.setLongitud(-45.6789);
            lugar2.setImagenUrl("lugar2.jpg");
            lugar2.setFechaCreacionLugar(LocalDateTime.now());

            // Nota: No se añaden familias aquí, ya que esto depende de la relación inversa

            lugarRepository.saveAll(List.of(lugar1, lugar2));
            System.out.println("Datos iniciales de Lugar cargados.");
        } else {
            System.out.println("Lugares ya existen, no se cargaron datos.");
        }
    }
}