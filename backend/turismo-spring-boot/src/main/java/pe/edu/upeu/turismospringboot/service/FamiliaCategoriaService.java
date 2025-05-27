package pe.edu.upeu.turismospringboot.service;

import pe.edu.upeu.turismospringboot.model.dto.FamiliaCategoriaDto;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaCategoriaDtoPost;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;
import pe.edu.upeu.turismospringboot.model.entity.FamiliaCategoria;

import java.util.List;

public interface FamiliaCategoriaService {
    public FamiliaCategoria asociarCategoriaAFamilia(FamiliaCategoriaDtoPost dto);
    public List<FamiliaCategoriaDto> listarRelaciones();
    public List<FamiliaCategoriaDto> obtenerFamiliaCategoriaPorIdFamilia(Long idFamilia);
    public List<FamiliaCategoriaDto> obtenerFamiliaCategoriaPorIdCategoria(Long idCategoria);
    public void eliminarRelacion(Long idRelacion);
    public List<Emprendimiento> getEmprendimientosPorFamiliaCategoria(Long idFamiliaCategoria, String nombre);
}
