package pe.edu.upeu.turismospringboot.util.dataLoaders;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;
import pe.edu.upeu.turismospringboot.model.entity.ServicioTuristico;
import pe.edu.upeu.turismospringboot.repository.EmprendimientoRepository;
import pe.edu.upeu.turismospringboot.repository.ServicioTuristicoRepository;

import java.util.List;

@Order(8)
@Component
@RequiredArgsConstructor
public class ServicioTuristicoDataLoader implements CommandLineRunner {

    private final EmprendimientoRepository emprendimientoRepository;
    private final ServicioTuristicoRepository servicioTuristicoRepository;

    @Override
    @Transactional
    public void run(String... args) {
        if (servicioTuristicoRepository.count() == 0) {
            List<Emprendimiento> emprendimientos = emprendimientoRepository.findAll();

            for (Emprendimiento emp : emprendimientos) {
                switch (emp.getNombre()) {
                    case "Hostal Estrella Andina" -> {
                        crearServicio(emp, "Habitación doble", "Cómoda habitación con vista a las montañas.", 120.0, "HOTELERIA", "servicio1.jpg");
                        crearServicio(emp, "Desayuno andino", "Incluye quinua, pan artesanal y mates locales.", 25.0, "HOTELERIA", "servicio2.jpg");
                    }
                    case "Sabores de Lunaria" -> {
                        crearServicio(emp, "Almuerzo tradicional", "Cocina fusión lunareña de tres tiempos.", 45.0, "GASTRONOMIA", "servicio3.jpg");
                        crearServicio(emp, "Cena temática", "Platos inspirados en mitos regionales.", 55.0, "GASTRONOMIA", "servicio4.jpg");
                    }
                    case "Manos de Barro" -> {
                        crearServicio(emp, "Clase de cerámica", "Taller con guía experto y materiales incluidos.", 80.0, "CULTURA", "servicio5.jpg");
                    }
                    case "Ciclotur Lunaria" -> {
                        crearServicio(emp, "Tour en bicicleta", "Recorrido guiado por 3 pueblos históricos.", 100.0, "CULTURA", "servicio6.jpg");
                    }
                    case "Aventura Kayak" -> {
                        crearServicio(emp, "Kayak en río encantado", "Excursión acuática con equipo y guía.", 90.0, "KAYAK", "servicio7.jpg");
                    }
                    case "Museo Vivo Lunaria" -> {
                        crearServicio(emp, "Entrada general", "Acceso completo a exposiciones interactivas.", 30.0, "CULTURA", "servicio8.jpg");
                        crearServicio(emp, "Tour guiado", "Recorrido narrado por mitos lunareños.", 40.0, "CULTURA", "servicio9.jpg");
                    }
                    case "Pack Aventurero" -> {
                        crearServicio(emp, "Pack Aventura", "Incluye alojamiento, comida y 2 experiencias.", 250.0, "HOTELERIA", "servicio10.jpg");
                    }
                }
            }

            System.out.println(">>> Servicios turísticos creados para los emprendimientos definidos.");
        }
    }

    private void crearServicio(Emprendimiento emp, String nombre, String descripcion, Double precio, String tipo, String imagen) {
        ServicioTuristico servicio = new ServicioTuristico();
        servicio.setNombre(nombre);
        servicio.setDescripcion(descripcion);
        servicio.setPrecioUnitario(precio);
        servicio.setTipoServicio(tipo);
        servicio.setImagenUrl(imagen);
        servicio.setEmprendimiento(emp);
        servicioTuristicoRepository.save(servicio);
    }
}