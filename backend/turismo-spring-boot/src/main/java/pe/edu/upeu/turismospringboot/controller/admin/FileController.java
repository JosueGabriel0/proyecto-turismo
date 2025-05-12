package pe.edu.upeu.turismospringboot.controller.admin;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import java.io.File;

@RestController
public class FileController {

    // Ruta de los archivos
    private static final String UPLOAD_DIR = "D:/Documentos/Universidad UPeU 6 ciclo/Desarrollo de aplicaciones moviles/proyecto-turismo/backend/turismo-spring-boot/upload/";

    @GetMapping("filePerfil/file/{fileName}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {
        try {
            // Crear el archivo desde la ruta completa
            File file = new File(UPLOAD_DIR + fileName);

            // Verificar si el archivo existe
            if (!file.exists()) {
                return ResponseEntity.notFound().build();
            }

            // Crear un recurso que apunta al archivo
            Resource resource = new FileSystemResource(file);

            // Establecer el tipo de contenido basado en la extensión del archivo
            String contentType = "application/octet-stream"; // Valor predeterminado
            if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
                contentType = "image/jpeg";
            } else if (fileName.endsWith(".png")) {
                contentType = "image/png";
            }

            // Establecer los encabezados para la respuesta (incluyendo el nombre de archivo)
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getName() + "\"")
                    .body(resource);

        } catch (Exception e) {
            // Si ocurre un error, retornar un error 500
            return ResponseEntity.status(500).build();
        }
    }
}