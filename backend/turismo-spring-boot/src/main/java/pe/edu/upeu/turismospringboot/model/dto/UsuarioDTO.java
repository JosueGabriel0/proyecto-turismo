package pe.edu.upeu.turismospringboot.model.dto;

import lombok.Data;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;

@Data
public class UsuarioDTO {
    private Long idUsuario;
    private String username;
    private String nombrePersona;
    private String rolNombre;

    // Constructor para crear desde entidad Usuario
    public UsuarioDTO(Usuario usuario) {
        this.idUsuario = usuario.getIdUsuario();
        this.username = usuario.getUsername();
        this.nombrePersona = usuario.getPersona() != null
                ? usuario.getPersona().getNombres() + " " + usuario.getPersona().getApellidos()
                : null;
        this.rolNombre = usuario.getRol() != null ? usuario.getRol().getNombre() : null;
    }
}