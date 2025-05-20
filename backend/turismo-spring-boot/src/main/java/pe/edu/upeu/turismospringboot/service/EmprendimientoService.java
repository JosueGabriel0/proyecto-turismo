package pe.edu.upeu.turismospringboot.service;

import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.EmprendimientoDto;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;

import java.util.List;

public interface EmprendimientoService {
    public List<Emprendimiento> getEmprendimientos();
    public Emprendimiento getEmprendimientoById(Long idEmprendimiento);
    public Emprendimiento postEmprendimiento(EmprendimientoDto emprendimientoDto, MultipartFile file);
    public Emprendimiento putEmprendimiento(Long idEmprendimiento, EmprendimientoDto emprendimientoDto, MultipartFile file);
    public void deleteEmprendimiento(Long idEmprendimiento);
    public List<Emprendimiento> buscarPorNombre(String nombre);
}
