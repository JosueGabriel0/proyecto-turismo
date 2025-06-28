package pe.edu.upeu.turismospringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.turismospringboot.model.entity.Mensaje;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;
import pe.edu.upeu.turismospringboot.model.enums.EstadoMensaje;

import java.util.List;

@Repository
public interface MensajeRepository extends JpaRepository<Mensaje, Long> {
    List<Mensaje> findByEmisor_IdUsuarioAndReceptor_IdUsuarioOrEmisor_IdUsuarioAndReceptor_IdUsuarioOrderByFechaEnvioAsc(
            Long emisorId1, Long receptorId1, Long emisorId2, Long receptorId2);

    @Query("""
    SELECT m FROM Mensaje m
    WHERE m.emisor.idUsuario = :usuarioId OR m.receptor.idUsuario = :usuarioId
    ORDER BY m.fechaEnvio DESC
""")
    List<Mensaje> findMensajesRecientesPorUsuario(@Param("usuarioId") Long usuarioId);

    List<Mensaje> findAllByEmisor_UsernameAndReceptor_UsernameAndEstado(
            String emisorUsername,
            String receptorUsername,
            EstadoMensaje estado
    );

    List<Mensaje> findAllByEmisor_UsernameAndReceptor_UsernameAndEstadoNot(
            String emisorUsername,
            String receptorUsername,
            EstadoMensaje estado
    );
}