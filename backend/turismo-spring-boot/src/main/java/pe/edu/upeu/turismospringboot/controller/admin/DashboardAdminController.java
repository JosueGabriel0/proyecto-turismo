package pe.edu.upeu.turismospringboot.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pe.edu.upeu.turismospringboot.model.dto.DashboardAdminDTO;
import pe.edu.upeu.turismospringboot.service.DashboardAdminService;

@RestController
@RequestMapping("/admin/dashboard")
public class DashboardAdminController {

    @Autowired
    private DashboardAdminService dashboardAdminService;

    @GetMapping
    public ResponseEntity<DashboardAdminDTO> obtenerDashboard() {
        DashboardAdminDTO dto = dashboardAdminService.obtenerDashboard();
        return ResponseEntity.ok(dto);
    }
}