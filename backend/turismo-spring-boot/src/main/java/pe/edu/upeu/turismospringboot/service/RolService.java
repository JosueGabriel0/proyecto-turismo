package pe.edu.upeu.turismospringboot.service;

import pe.edu.upeu.turismospringboot.model.dto.RolDto;
import pe.edu.upeu.turismospringboot.model.entity.Rol;

import java.util.List;

public interface RolService {
    public List<Rol> listarRoles();
    public Rol obtenerRolPorId(Long idRol);
    public Rol guardarRol(RolDto rolDto);
    public Rol actualizarRol(Long idRol, RolDto rolDto);
    public void eliminarRolPorId(Long idRol);
    public List<Rol> buscarRolesPorNombre(String nombre);
}
