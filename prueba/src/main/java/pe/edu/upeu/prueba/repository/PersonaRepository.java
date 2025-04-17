package pe.edu.upeu.prueba.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.prueba.model.entity.Persona;

@Repository
public interface PersonaRepository extends JpaRepository<Persona, Long> {
}
