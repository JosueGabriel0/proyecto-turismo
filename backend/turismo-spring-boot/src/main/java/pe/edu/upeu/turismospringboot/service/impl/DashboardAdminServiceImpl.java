package pe.edu.upeu.turismospringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pe.edu.upeu.turismospringboot.model.dto.DashboardAdminDTO;
import pe.edu.upeu.turismospringboot.model.enums.EstadoReserva;
import pe.edu.upeu.turismospringboot.repository.EmprendimientoRepository;
import pe.edu.upeu.turismospringboot.repository.ResenaRepository;
import pe.edu.upeu.turismospringboot.repository.ReservaRepository;
import pe.edu.upeu.turismospringboot.repository.UsuarioRepository;
import pe.edu.upeu.turismospringboot.service.DashboardAdminService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DashboardAdminServiceImpl implements DashboardAdminService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private ReservaRepository reservaRepository;

    @Autowired
    private EmprendimientoRepository emprendimientoRepository;

    @Autowired
    private ResenaRepository resenaRepository;

    @Override
    public DashboardAdminDTO obtenerDashboard() {
        // Obtener totales
        Long totalUsuarios = usuarioRepository.count();
        Long totalReservas = reservaRepository.count();
        Long totalEmprendimientos = emprendimientoRepository.count();
        Long totalResenas = resenaRepository.count();

        // Conteo reservas por estado
        Map<String, Long> reservasPorEstado = new HashMap<>();
        reservasPorEstado.put("Pendiente", reservaRepository.countByEstado(EstadoReserva.PENDIENTE));
        reservasPorEstado.put("Confirmada", reservaRepository.countByEstado(EstadoReserva.CONFIRMADA));
        reservasPorEstado.put("Cancelada", reservaRepository.countByEstado(EstadoReserva.CANCELADA));

        // Conteo emprendimientos por categoría
        List<Object[]> conteoCategorias = emprendimientoRepository.countByCategoria();
        Map<String, Long> emprendimientosPorCategoria = new HashMap<>();
        for (Object[] fila : conteoCategorias) {
            String categoria = (String) fila[0];
            Long cantidad = (Long) fila[1];
            emprendimientosPorCategoria.put(categoria, cantidad);
        }

        // Construir DTO y devolver
        return new DashboardAdminDTO(
                totalUsuarios,
                totalReservas,
                totalEmprendimientos,
                totalResenas,
                reservasPorEstado,
                emprendimientosPorCategoria
        );
    }
}