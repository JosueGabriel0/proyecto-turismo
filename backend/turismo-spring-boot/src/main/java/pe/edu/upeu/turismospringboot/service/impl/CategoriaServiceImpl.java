package pe.edu.upeu.turismospringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.CategoriaDto;
import pe.edu.upeu.turismospringboot.model.entity.Categoria;
import pe.edu.upeu.turismospringboot.model.entity.Familia;
import pe.edu.upeu.turismospringboot.repository.CategoriaRepository;
import pe.edu.upeu.turismospringboot.repository.FamiliaRepository;
import pe.edu.upeu.turismospringboot.service.CategoriaService;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class CategoriaServiceImpl implements CategoriaService {
    @Autowired
    private CategoriaRepository categoriaRepository;

    @Override
    public List<Categoria> getCategorias() {
        return categoriaRepository.findAll();
    }

    @Override
    public Categoria getCategoriaById(Long idCategoria) {
        return categoriaRepository.findById(idCategoria).orElseThrow(() -> new RuntimeException("La categoria con id "+idCategoria+" no existe"));
    }

    @Override
    public Categoria postCategoria(CategoriaDto categoriaDto, MultipartFile file) {
        Categoria categoria = new Categoria();
        categoria.setNombre(categoriaDto.getNombre());
        categoria.setDescripcion(categoriaDto.getDescripcion());

        if(file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            categoria.setImagenUrl(fileName);
        }

        return categoriaRepository.save(categoria);
    }

    @Override
    public Categoria putCategoria(Long idCategoria, CategoriaDto categoriaDto, MultipartFile file) {
        Categoria categoriaEncontrada = categoriaRepository.findById(idCategoria).orElseThrow(() -> new RuntimeException("La categoria con id "+idCategoria+" no existe"));
        categoriaEncontrada.setNombre(categoriaDto.getNombre());
        categoriaEncontrada.setDescripcion(categoriaDto.getDescripcion());
        if(file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            categoriaEncontrada.setImagenUrl(fileName);
        }

        return categoriaRepository.save(categoriaEncontrada);
    }

    @Override
    public void deleteCategoria(Long idCategoria) {
        categoriaRepository.deleteById(idCategoria);
    }

    private static final String UPLOAD_DIR = System.getProperty("user.dir") + "/upload/";
    private String saveFile(MultipartFile file) {
        try {
            File uploadPath = new File(UPLOAD_DIR);
            if (!uploadPath.exists()) {
                uploadPath.mkdirs();
            }
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File destinationFile = new File(uploadPath, fileName);
            file.transferTo(destinationFile);
            return fileName;
        } catch (IOException e) {
            throw new RuntimeException("Error al guardar la imagen", e);
        }
    }

    @Override
    public List<Categoria> buscarPorNombre(String nombre) {
        return categoriaRepository.buscarPorNombre(nombre);
    }
}
