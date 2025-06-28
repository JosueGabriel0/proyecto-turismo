package pe.edu.upeu.turismospringboot.controller.usuario;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@RestController
@RequestMapping("/usuario/file")
public class FileUsuarioController {

    private final String BASE_DIR = "upload";

    @PostMapping("/upload")
    public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile file,
                                             @RequestParam("tipo") String tipo) throws IOException {
        String carpetaDestino;

        switch (tipo.toUpperCase()) {
            case "AUDIO": carpetaDestino = "audios"; break;
            case "DOCUMENTO": carpetaDestino = "documentos"; break;
            case "IMAGEN": carpetaDestino = "imagenes"; break;
            case "VIDEO": carpetaDestino = "videos"; break;
            default: return ResponseEntity.badRequest().body("Tipo inválido");
        }

        String nombreArchivo = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path rutaArchivo = Paths.get(BASE_DIR, carpetaDestino, nombreArchivo);
        Files.createDirectories(rutaArchivo.getParent());
        Files.write(rutaArchivo, file.getBytes());

        // Devuelve la URL para acceder al archivo
        return ResponseEntity.ok(nombreArchivo);
    }

    @GetMapping("/{tipo}/{filename:.+}")
    public ResponseEntity<Resource> verArchivo(
            @PathVariable String tipo,
            @PathVariable String filename,
            HttpServletRequest request) {

        try {
            Path filePath = Paths.get(BASE_DIR, tipo, filename);
            Resource resource = new UrlResource(filePath.toUri());

            if (!resource.exists()) {
                return ResponseEntity.notFound().build();
            }

            // Obtener el tipo de contenido (MIME type)
            String contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
            if (contentType == null) {
                contentType = "application/octet-stream"; // Tipo genérico
            }

            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType))
                    .body(resource);

        } catch (MalformedURLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
