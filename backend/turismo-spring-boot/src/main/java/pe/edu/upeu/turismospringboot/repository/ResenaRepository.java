package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pe.edu.upeu.turismospringboot.model.entity.Resena;

public interface ResenaRepository extends JpaRepository<Resena, Long> {
    long count();
}
