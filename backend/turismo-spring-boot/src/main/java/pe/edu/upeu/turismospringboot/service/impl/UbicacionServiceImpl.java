package pe.edu.upeu.turismospringboot.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pe.edu.upeu.turismospringboot.model.dto.UbicacionDTO;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;
import pe.edu.upeu.turismospringboot.repository.EmprendimientoRepository;
import pe.edu.upeu.turismospringboot.repository.LugarRepository;
import pe.edu.upeu.turismospringboot.service.UbicacionService;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UbicacionServiceImpl implements UbicacionService {

    private final EmprendimientoRepository emprendimientoRepository;
    private final LugarRepository lugarRepository;

    @Override
    public List<UbicacionDTO> obtenerTodasLasUbicaciones() {
        List<UbicacionDTO> ubicaciones = new ArrayList<>();

        List<Lugar> lugares = lugarRepository.findAll();
        for (Lugar lugar : lugares) {
            ubicaciones.add(new UbicacionDTO(
                    lugar.getLatitud(),
                    lugar.getLongitud(),
                    lugar.getNombre(),
                    "lugar",
                    lugar.getDescripcion(),
                    lugar.getImagenUrl()
            ));
        }

        List<Emprendimiento> emprendimientos = emprendimientoRepository.findAll();
        for (Emprendimiento emp : emprendimientos) {
            ubicaciones.add(new UbicacionDTO(
                    emp.getLatitud(),
                    emp.getLongitud(),
                    emp.getNombre(),
                    "emprendimiento",
                    emp.getDescripcion(),
                    emp.getImagenUrl()
            ));
        }

        return ubicaciones;
    }
}