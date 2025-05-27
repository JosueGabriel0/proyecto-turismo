package pe.edu.upeu.turismospringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaCategoriaDto;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaCategoriaDtoPost;
import pe.edu.upeu.turismospringboot.model.entity.*;
import pe.edu.upeu.turismospringboot.repository.CategoriaRepository;
import pe.edu.upeu.turismospringboot.repository.FamiliaCategoriaRepository;
import pe.edu.upeu.turismospringboot.repository.FamiliaRepository;
import pe.edu.upeu.turismospringboot.service.FamiliaCategoriaService;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class FamiliaCategoriaServiceImpl implements FamiliaCategoriaService {
    @Autowired
    private FamiliaCategoriaRepository familiaCategoriaRepository;
    @Autowired
    private FamiliaRepository familiaRepository;
    @Autowired
    private CategoriaRepository categoriaRepository;

    @Override
    public FamiliaCategoria asociarCategoriaAFamilia(FamiliaCategoriaDtoPost dto) {
        Familia familia = familiaRepository.findById(dto.getIdFamilia()).orElseThrow(() -> new RuntimeException("No existe la familia"));
        Categoria categoria = categoriaRepository.findById(dto.getIdCategoria()).orElseThrow(() -> new RuntimeException("Categoría no encontrada"));

        FamiliaCategoria relacion = new FamiliaCategoria();
        relacion.setFamilia(familia);
        relacion.setCategoria(categoria);

        return familiaCategoriaRepository.save(relacion);
    }

    @Override
    public List<FamiliaCategoriaDto> listarRelaciones() {
        List<FamiliaCategoria> familiaCategorias = familiaCategoriaRepository.findAll();
        return familiaCategorias.stream().map(f -> {
            FamiliaCategoriaDto dto = new FamiliaCategoriaDto();
            dto.setIdFamiliaCategoria(f.getIdFamiliaCategoria());
            dto.setIdFamilia(f.getFamilia().getIdFamilia());
            dto.setNombreFamilia(f.getFamilia().getNombre());
            dto.setIdCategoria(f.getCategoria().getIdCategoria());
            dto.setNombreCategoria(f.getCategoria().getNombre());
            dto.setEmprendimientos(f.getEmprendimientos());
            dto.setFechaCreacionFamiliaCategoria(f.getFechaCreacionFamiliaCategoria());
            dto.setFechaModificacionFamiliaCategoria(f.getFechaModificacionFamiliaCategoria());
            return dto;
        }).collect(Collectors.toList());
    }

    @Override
    public List<FamiliaCategoriaDto> obtenerFamiliaCategoriaPorIdFamilia(Long idFamilia){
        List<FamiliaCategoria> familiaCategorias = familiaCategoriaRepository.findByFamiliaIdFamilia(idFamilia);
        return familiaCategorias.stream().map(f -> {
            FamiliaCategoriaDto dto = new FamiliaCategoriaDto();
            dto.setIdFamiliaCategoria(f.getIdFamiliaCategoria());
            dto.setIdFamilia(f.getFamilia().getIdFamilia());
            dto.setNombreFamilia(f.getFamilia().getNombre());
            dto.setIdCategoria(f.getCategoria().getIdCategoria());
            dto.setNombreCategoria(f.getCategoria().getNombre());
            dto.setEmprendimientos(f.getEmprendimientos());
            dto.setFechaCreacionFamiliaCategoria(f.getFechaCreacionFamiliaCategoria());
            dto.setFechaModificacionFamiliaCategoria(f.getFechaModificacionFamiliaCategoria());
            return dto;
        }).collect(Collectors.toList());
    }

    @Override
    public List<FamiliaCategoriaDto> obtenerFamiliaCategoriaPorIdCategoria(Long idCategoria){
        List<FamiliaCategoria> familiaCategorias = familiaCategoriaRepository.findByCategoriaIdCategoria(idCategoria);
        return familiaCategorias.stream().map(f -> {
            FamiliaCategoriaDto dto = new FamiliaCategoriaDto();
            dto.setIdFamiliaCategoria(f.getIdFamiliaCategoria());
            dto.setIdFamilia(f.getFamilia().getIdFamilia());
            dto.setNombreFamilia(f.getFamilia().getNombre());
            dto.setIdCategoria(f.getCategoria().getIdCategoria());
            dto.setNombreCategoria(f.getCategoria().getNombre());
            dto.setEmprendimientos(f.getEmprendimientos());
            dto.setFechaCreacionFamiliaCategoria(f.getFechaCreacionFamiliaCategoria());
            dto.setFechaModificacionFamiliaCategoria(f.getFechaModificacionFamiliaCategoria());
            return dto;
        }).collect(Collectors.toList());
    }

    @Override
    public void eliminarRelacion(Long idRelacion) {
        familiaCategoriaRepository.deleteById(idRelacion);
    }

    @Override
    public List<Emprendimiento> getEmprendimientosPorFamiliaCategoria(Long idFamiliaCategoria, String nombre) {
        FamiliaCategoria familiaCategoria = familiaCategoriaRepository.findById(idFamiliaCategoria)
                .orElseThrow(() -> new RuntimeException("FamiliaCategoria no encontrada"));

        List<Emprendimiento> emprendimientos = familiaCategoria.getEmprendimientos();

        if (nombre != null && !nombre.isEmpty()) {
            return emprendimientos.stream()
                    .filter(e -> e.getNombre().toLowerCase().contains(nombre.toLowerCase()))
                    .collect(Collectors.toList());
        }

        return emprendimientos;
    }
}
