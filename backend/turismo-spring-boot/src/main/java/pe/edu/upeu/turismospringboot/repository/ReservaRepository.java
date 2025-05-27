package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.turismospringboot.model.entity.Reserva;

@Repository
public interface ReservaRepository extends JpaRepository<Reserva, Long> {
}
