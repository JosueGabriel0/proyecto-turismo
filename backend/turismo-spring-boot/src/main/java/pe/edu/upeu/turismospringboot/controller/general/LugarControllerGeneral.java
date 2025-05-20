package pe.edu.upeu.turismospringboot.controller.general;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pe.edu.upeu.turismospringboot.model.entity.Lugar;
import pe.edu.upeu.turismospringboot.service.LugarService;

import java.util.List;

@RestController
@RequestMapping("/general/lugar")
public class LugarControllerGeneral {
    @Autowired
    private LugarService lugarService;

    @GetMapping
    public ResponseEntity<List<Lugar>> listarLugares(){
        return ResponseEntity.ok(lugarService.getlugares());
    }
}
