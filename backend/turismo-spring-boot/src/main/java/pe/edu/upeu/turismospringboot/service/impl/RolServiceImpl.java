package pe.edu.upeu.turismospringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pe.edu.upeu.turismospringboot.model.dto.RolDto;
import pe.edu.upeu.turismospringboot.model.entity.Rol;
import pe.edu.upeu.turismospringboot.repository.RolRepository;
import pe.edu.upeu.turismospringboot.service.RolService;

import java.util.List;

@Service
public class RolServiceImpl implements RolService {
    @Autowired
    private RolRepository rolRepository;

    @Override
    public List<Rol> listarRoles() {
        return rolRepository.findAll();
    }

    @Override
    public Rol obtenerRolPorId(Long idRol) {
        return rolRepository.findById(idRol).orElseThrow(() -> new RuntimeException("No se encontro el rol con id: " + idRol));
    }

    @Override
    public Rol guardarRol(RolDto rolDto) {
        Rol rol = new Rol();
        rol.setNombre(rolDto.getNombre());
        return rolRepository.save(rol);
    }

    @Override
    public Rol actualizarRol(Long idRol, RolDto rolDto) {
        Rol rolEncontrado = rolRepository.findById(idRol).orElseThrow(() -> new RuntimeException("No se encontro el rol con id: " + idRol));

        rolEncontrado.setNombre(rolDto.getNombre());
        return rolRepository.save(rolEncontrado);
    }

    @Override
    public void eliminarRolPorId(Long idRol) {
        rolRepository.deleteById(idRol);
    }

    @Override
    public List<Rol> buscarRolesPorNombre(String nombre) {
        return rolRepository.buscarPorNombre(nombre);
    }
}
