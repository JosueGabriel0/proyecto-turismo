package pe.edu.upeu.turismospringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.FamiliaDto;
import pe.edu.upeu.turismospringboot.model.entity.Familia;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;
import pe.edu.upeu.turismospringboot.repository.FamiliaRepository;
import pe.edu.upeu.turismospringboot.repository.LugarRepository;
import pe.edu.upeu.turismospringboot.service.FamiliaService;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class FamiliaServiceImpl implements FamiliaService {
    @Autowired
    private FamiliaRepository familiaRepository;

    @Autowired
    private LugarRepository lugarRepository;

    @Override
    public List<Familia> getFamilias() {
        return familiaRepository.findAll();
    }

    @Override
    public Familia getFamiliaById(Long idFamilia) {
        return familiaRepository.findById(idFamilia).orElseThrow(() -> new RuntimeException("Familia con id "+idFamilia+" no enctrada"));
    }

    @Override
    public Familia postFamilia(FamiliaDto familiaDto, MultipartFile file) {
        Lugar lugar = lugarRepository.findByNombre(familiaDto.getNombreLugar()).orElseThrow(()-> new RuntimeException("Lugar con nombre "+familiaDto.getNombreLugar()+" no enctrado"));
        Familia familia = new Familia();
        familia.setNombre(familiaDto.getNombre());
        familia.setDescripcion(familiaDto.getDescripcion());
        familia.setLugar(lugar);
        if(file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            familia.setImagenUrl(fileName);
        }
        return familiaRepository.save(familia);
    }

    @Override
    public Familia putFamilia(Long idFamilia, FamiliaDto familiaDto, MultipartFile file) {
        Familia familia = familiaRepository.findById(idFamilia).orElseThrow(() -> new RuntimeException("Familia con id "+idFamilia+" no enctrada"));
        Lugar lugar = lugarRepository.findByNombre(familiaDto.getNombreLugar()).orElseThrow(()-> new RuntimeException("Lugar con nombre "+familiaDto.getNombreLugar()+" no enctrado"));
        familia.setNombre(familiaDto.getNombre());
        familia.setDescripcion(familiaDto.getDescripcion());
        familia.setLugar(lugar);
        if(file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            familia.setImagenUrl(fileName);
        }
        return familiaRepository.save(familia);
    }

    @Override
    public void deleteFamilia(Long idFamilia) {
        familiaRepository.deleteById(idFamilia);
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
    public List<Familia> buscarPorNombre(String nombre) {
        return familiaRepository.buscarPorNombre(nombre);
    }
}
