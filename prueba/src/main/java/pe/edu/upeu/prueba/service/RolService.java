package pe.edu.upeu.prueba.service;

import pe.edu.upeu.prueba.model.entity.Rol;

import java.util.List;

public interface RolService {
    public List<Rol> listarRoles();
    public Rol obtenerRolPorId(Long idRol);
    public Rol guardarRol(Rol rol);
    public Rol actualizarRol(Rol rol);
    public void eliminarRolPorId(Long idRol);
}
