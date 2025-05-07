package pe.edu.upeu.turismospringboot.config;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class LocalDateDeserializer extends JsonDeserializer<LocalDate> {

    @Override
    public LocalDate deserialize(JsonParser p, DeserializationContext ctxt) throws IOException, JsonProcessingException {
        // Extraemos el texto de la fecha (suponiendo que la fecha está en formato "yyyy-MM-dd")
        String dateStr = p.getText();

        // Definimos el formato de la fecha que esperamos (en este caso "yyyy-MM-dd")
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // Deserializamos la fecha utilizando el formato
        return LocalDate.parse(dateStr, formatter);
    }
}