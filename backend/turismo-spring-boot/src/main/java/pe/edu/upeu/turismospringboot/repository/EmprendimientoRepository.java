package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;

import java.util.Optional;

@Repository
public interface EmprendimientoRepository extends JpaRepository<Emprendimiento, Long> {
    Optional<Emprendimiento> findByNombre(String nombre);
}
