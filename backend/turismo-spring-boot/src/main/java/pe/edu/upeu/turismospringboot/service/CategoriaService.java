package pe.edu.upeu.turismospringboot.service;

import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.CategoriaDto;
import pe.edu.upeu.turismospringboot.model.entity.Categoria;

import java.util.List;

public interface CategoriaService {
    public List<Categoria> getCategorias();
    public Categoria getCategoriaById(Long idCategoria);
    public Categoria postCategoria(CategoriaDto categoriaDto, MultipartFile file);
    public Categoria putCategoria(Long idCategoria, CategoriaDto categoriaDto, MultipartFile file);
    public void deleteCategoria(Long idCategoria);
    List<Categoria> buscarPorNombre(String nombre);
}
