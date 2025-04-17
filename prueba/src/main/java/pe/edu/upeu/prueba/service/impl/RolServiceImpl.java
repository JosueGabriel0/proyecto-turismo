package pe.edu.upeu.prueba.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pe.edu.upeu.prueba.model.entity.Rol;
import pe.edu.upeu.prueba.repository.RolRepository;
import pe.edu.upeu.prueba.service.RolService;

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
    public Rol guardarRol(Rol rol) {
        return rolRepository.save(rol);
    }

    @Override
    public Rol actualizarRol(Rol rol) {
        return rolRepository.save(rol);
    }

    @Override
    public void eliminarRolPorId(Long idRol) {
        rolRepository.deleteById(idRol);
    }
}
