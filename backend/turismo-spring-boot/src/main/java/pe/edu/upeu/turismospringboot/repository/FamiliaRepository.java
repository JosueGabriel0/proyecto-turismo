package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.turismospringboot.model.entity.Familia;

import java.util.List;
import java.util.Optional;

@Repository
public interface FamiliaRepository extends JpaRepository<Familia, Long> {
    Optional<Familia> findByNombre(String nombre);

    @Query("SELECT f FROM Familia f WHERE LOWER(f.nombre) LIKE LOWER(CONCAT('%', :nombre, '%'))")
    List<Familia> buscarPorNombre(@Param("nombre") String nombre);
}
