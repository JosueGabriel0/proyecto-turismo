package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.turismospringboot.model.entity.Familia;

import java.util.Optional;

@Repository
public interface FamiliaRepository extends JpaRepository<Familia, Long> {
    Optional<Familia> findByNombre(String nombre);
}
