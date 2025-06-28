package pe.edu.upeu.turismospringboot.service;

import pe.edu.upeu.turismospringboot.model.dto.UbicacionDTO;

import java.util.List;

public interface UbicacionService {
    List<UbicacionDTO> obtenerTodasLasUbicaciones();
}