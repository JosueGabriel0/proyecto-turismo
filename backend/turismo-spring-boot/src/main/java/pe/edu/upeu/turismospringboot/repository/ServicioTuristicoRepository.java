package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.turismospringboot.model.entity.ServicioTuristico;

import java.util.List;

@Repository
public interface ServicioTuristicoRepository extends JpaRepository<ServicioTuristico, Long> {
    @Query("SELECT l FROM ServicioTuristico l WHERE LOWER(l.nombre) LIKE LOWER(CONCAT('%', :nombre, '%'))")
    List<ServicioTuristico> buscarPorNombre(@Param("nombre") String nombre);
}
