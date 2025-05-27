package pe.edu.upeu.turismospringboot.service;

import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.ServicioTuristicoDto;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;
import pe.edu.upeu.turismospringboot.model.entity.ServicioTuristico;

import java.util.List;

public interface ServicioTuristicoService {
    public List<ServicioTuristico> getServicioTuristicos();
    public ServicioTuristico getServicioTuristicoById(Long id);
    public ServicioTuristico postServicioTuristico(ServicioTuristicoDto servicioTuristicoDto, MultipartFile multipartFile);
    public ServicioTuristico putServicioTuristico(Long idServicio, ServicioTuristicoDto servicioTuristicoDto, MultipartFile multipartFile);
    public void deleteServicioTuristico(Long idServicio);
    public List<ServicioTuristico> buscarServicioTuristicoPorNombre(String nombre);
}
