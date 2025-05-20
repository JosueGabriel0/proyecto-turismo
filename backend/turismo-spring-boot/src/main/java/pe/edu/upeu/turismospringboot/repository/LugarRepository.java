package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;

import java.util.List;
import java.util.Optional;

@Repository
public interface LugarRepository extends JpaRepository<Lugar, Long> {
    Optional<Lugar> findByNombre(String nombre);

    @Query("SELECT l FROM Lugar l WHERE LOWER(l.nombre) LIKE LOWER(CONCAT('%', :nombre, '%'))")
    List<Lugar> buscarPorNombre(@Param("nombre") String nombre);
}
