package pe.edu.upeu.turismospringboot.model.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import lombok.Data;
import pe.edu.upeu.turismospringboot.config.LocalDateDeserializer;

import java.time.LocalDate;

@Data
public class UsuarioDtoUser {
    private String username;
    private String password;
    private String nombres;
    private String apellidos;
    private String tipoDocumento;
    private String numeroDocumento;
    private String telefono;
    private String direccion;
    private String correoElectronico;
    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate fechaNacimiento;
}