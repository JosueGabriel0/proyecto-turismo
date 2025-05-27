package pe.edu.upeu.turismospringboot.service;

import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.LugarDto;
import pe.edu.upeu.turismospringboot.model.entity.Familia;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;

import java.util.List;

public interface LugarService {
    public List<Lugar> getlugares();
    public Lugar getLugarById(Long idLugar);
    public Lugar postLugar(LugarDto lugarDto, MultipartFile file);
    public Lugar putLugar(Long idLugar, LugarDto lugarDto, MultipartFile file);
    public void deleteLugar(Long idLugar);
    public List<Lugar> buscarLugarPorNombre(String nombre);
    public List<Familia> getFamiliasPorLugar(Long idLugar, String nombre);
}
