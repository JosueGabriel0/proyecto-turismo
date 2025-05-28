package pe.edu.upeu.turismospringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.ServicioTuristicoDto;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;
import pe.edu.upeu.turismospringboot.model.entity.ServicioTuristico;
import pe.edu.upeu.turismospringboot.repository.EmprendimientoRepository;
import pe.edu.upeu.turismospringboot.repository.ServicioTuristicoRepository;
import pe.edu.upeu.turismospringboot.service.ServicioTuristicoService;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class ServicioTuristicoServiceImpl implements ServicioTuristicoService {
    @Autowired
    private ServicioTuristicoRepository servicioTuristicoRepository;

    @Autowired
    private EmprendimientoRepository emprendimientoRepository;

    @Override
    public List<ServicioTuristico> getServicioTuristicos() {
        return servicioTuristicoRepository.findAll();
    }

    @Override
    public List<ServicioTuristico> getServicioTuristicosPorIdEmprendimiento(Long idEmprendimiento){
        Emprendimiento emprendimientoEncontrado = emprendimientoRepository.findById(idEmprendimiento).orElseThrow(
                () -> new RuntimeException("No existe el emprendimiento con id"+ idEmprendimiento)
        );
        List<ServicioTuristico> servicioTuristicos = emprendimientoEncontrado.getServicioTuristicos();
        return servicioTuristicos;
    }

    @Override
    public ServicioTuristico getServicioTuristicoById(Long idServicio) {
        return servicioTuristicoRepository.findById(idServicio).orElseThrow(() -> new RuntimeException("ServicioTuristico con id: "+idServicio+"no encontrado"));
    }

    @Override
    public ServicioTuristico postServicioTuristico(ServicioTuristicoDto servicioTuristicoDto, MultipartFile multipartFile) {
        Emprendimiento emprendimientoEncontrado = emprendimientoRepository.findByNombre(servicioTuristicoDto.getNombreEmprendimiento()).orElseThrow(() -> new RuntimeException("Emprendimiento con nombre"+servicioTuristicoDto.getNombreEmprendimiento()+" no encontrado"));
        ServicioTuristico servicioTuristico = new ServicioTuristico();
        servicioTuristico.setNombre(servicioTuristicoDto.getNombre());
        servicioTuristico.setDescripcion(servicioTuristicoDto.getDescripcion());
        servicioTuristico.setPrecioUnitario(servicioTuristicoDto.getPrecioUnitario());
        servicioTuristico.setTipoServicio(servicioTuristicoDto.getTipoServicio());
        servicioTuristico.setEmprendimiento(emprendimientoEncontrado);

        if(multipartFile != null && !multipartFile.isEmpty()) {
            String fileName = saveFile(multipartFile);
            servicioTuristico.setImagenUrl(fileName);
        }
        return servicioTuristicoRepository.save(servicioTuristico);
    }

    @Override
    public ServicioTuristico putServicioTuristico(Long idServicio, ServicioTuristicoDto servicioTuristicoDto, MultipartFile multipartFile) {
        Emprendimiento emprendimientoEncontrado = emprendimientoRepository.findByNombre(servicioTuristicoDto.getNombreEmprendimiento()).orElseThrow(() -> new RuntimeException("Emprendimiento con nombre"+servicioTuristicoDto.getNombreEmprendimiento()+" no encontrado"));
        ServicioTuristico servicioTuristicoEncontrado = servicioTuristicoRepository.findById(idServicio).orElseThrow(() -> new RuntimeException("ServicioTuristico con id "+idServicio+"no encontrado"));
        servicioTuristicoEncontrado.setNombre(servicioTuristicoDto.getNombre());
        servicioTuristicoEncontrado.setDescripcion(servicioTuristicoDto.getDescripcion());
        servicioTuristicoEncontrado.setPrecioUnitario(servicioTuristicoDto.getPrecioUnitario());
        servicioTuristicoEncontrado.setTipoServicio(servicioTuristicoDto.getTipoServicio());
        servicioTuristicoEncontrado.setEmprendimiento(emprendimientoEncontrado);

        if(multipartFile != null && !multipartFile.isEmpty()) {
            String fileName = saveFile(multipartFile);
            servicioTuristicoEncontrado.setImagenUrl(fileName);
        }
        return servicioTuristicoRepository.save(servicioTuristicoEncontrado);
    }

    @Override
    public void deleteServicioTuristico(Long idServicio) {
        servicioTuristicoRepository.deleteById(idServicio);
    }

    @Override
    public List<ServicioTuristico> buscarServicioTuristicoPorNombre(String nombre) {
        return servicioTuristicoRepository.buscarPorNombre(nombre);
    }

    @Override
    public List<ServicioTuristico> buscarServicioTuristicoPorIdEmprendimiento(Long idEmprendimiento){
        Emprendimiento emprendimiento = emprendimientoRepository.findById(idEmprendimiento).orElseThrow(() -> new RuntimeException("No se encontro el emprendimiento con id "+idEmprendimiento));
        List<ServicioTuristico> servicioTuristicos = emprendimiento.getServicioTuristicos();
        return servicioTuristicos;
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
}
