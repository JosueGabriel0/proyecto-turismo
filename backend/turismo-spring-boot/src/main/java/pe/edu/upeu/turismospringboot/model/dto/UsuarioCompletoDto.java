package pe.edu.upeu.turismospringboot.model.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class UsuarioCompletoDto {
    private String username;
    private String password;
    private String estadoCuenta;
    private String nombreRol;
    private String nombres;
    private String apellidos;
    private String tipoDocumento;
    private String numeroDocumento;
    private String telefono;
    private String direccion;
    private String correoElectronico;
    private String fotoPerfil;
    private LocalDate fechaNacimiento;
}
