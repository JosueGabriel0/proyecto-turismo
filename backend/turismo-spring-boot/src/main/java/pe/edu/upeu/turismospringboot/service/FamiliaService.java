package pe.edu.upeu.turismospringboot.service;

import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaDto;
import pe.edu.upeu.turismospringboot.model.entity.Familia;

import java.util.List;

public interface FamiliaService {
    public List<Familia> getFamilias();
    public Familia getFamiliaById(Long idFamilia);
    public Familia postFamilia(FamiliaDto familiaDto, MultipartFile file);
    public Familia putFamilia(Long idFamilia, FamiliaDto familiaDto, MultipartFile file);
    public void deleteFamilia(Long idFamilia);
    public List<Familia> buscarPorNombre(String nombre);
}
