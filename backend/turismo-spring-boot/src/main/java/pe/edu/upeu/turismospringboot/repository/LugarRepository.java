package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;

import java.util.Optional;

@Repository
public interface LugarRepository extends JpaRepository<Lugar, Long> {
    Optional<Lugar> findByNombre(String nombre);
}
