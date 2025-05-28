package pe.edu.upeu.turismospringboot.controller.emprendedor;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.turismospringboot.model.dto.EmprendimientoDto;
import pe.edu.upeu.turismospringboot.model.entity.Emprendimiento;
import pe.edu.upeu.turismospringboot.service.EmprendimientoService;

@RestController
@RequestMapping("/emprendedor/emprendimiento")
public class EmprendimientoControllerEmprendedor {

    @Autowired
    private EmprendimientoService emprendimientoService;

    @GetMapping("/usuario/{idUsuario}")
    public ResponseEntity<Emprendimiento> getEmprendimientoByIdUsuario(
            @PathVariable("idUsuario") Long idUsuario) {
        return ResponseEntity.ok(emprendimientoService.buscarPorIdUsuario(idUsuario));
    }

    @PutMapping("/{idEmprendimiento}")
    public ResponseEntity<Emprendimiento> updateEmprendimiento(
            @PathVariable("idEmprendimiento") Long idEmprendimiento,
            @RequestPart(value = "emprendimiento") String emprendimientoJson,
            @RequestPart(value = "file", required = false) MultipartFile file
    ){
        try{
            ObjectMapper mapper = new ObjectMapper();
            EmprendimientoDto emprendimientoDto = mapper.readValue(emprendimientoJson, EmprendimientoDto.class);
            Emprendimiento emprendimientoActualizado = emprendimientoService.putEmprendimiento(idEmprendimiento, emprendimientoDto, file);
            return ResponseEntity.ok(emprendimientoActualizado);
        }catch (Exception e){
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
