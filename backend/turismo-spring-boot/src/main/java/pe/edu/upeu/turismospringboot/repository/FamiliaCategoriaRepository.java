package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.turismospringboot.model.entity.FamiliaCategoria;

import java.util.List;

@Repository
public interface FamiliaCategoriaRepository extends JpaRepository<FamiliaCategoria, Long> {
    List<FamiliaCategoria> findByFamiliaIdFamilia(Long familiaId);
    List<FamiliaCategoria> findByCategoriaIdCategoria(Long categoriaId);
}
