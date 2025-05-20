package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;

import java.util.List;
import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    Optional<Usuario> findByUsername(String username);

    @Query("SELECT u FROM Usuario u WHERE LOWER(u.username) LIKE LOWER(CONCAT('%', :username, '%'))")
    List<Usuario> buscarPorUsername(@Param("username") String username);
}
