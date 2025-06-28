package pe.edu.upeu.turismospringboot.model.enums;

public enum EstadoMensaje {
    PENDIENTE,     // (opcional) El cliente creó el mensaje pero no se pudo enviar (offline)
    ENVIADO,       // El backend lo recibió correctamente
    ENTREGADO,     // Llegó al cliente receptor (WebSocket suscrito)
    LEIDO,         // El receptor abrió el mensaje (visto)
    ERROR_ENVIO    // Fallo al guardar o enviar
}