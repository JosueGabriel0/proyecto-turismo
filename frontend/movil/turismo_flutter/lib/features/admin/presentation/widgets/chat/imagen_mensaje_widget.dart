import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/chat/imagen_desde_bloc_widget.dart';

class ImagenMensajeWidget extends StatelessWidget {
  final String nombreArchivo;
  final bool esMio;
  final DateTime fecha;
  final String estado;

  final Color myColor;
  final Color otherColor;
  final Color estadoColor;

  const ImagenMensajeWidget({
    super.key,
    required this.nombreArchivo,
    required this.esMio,
    required this.fecha,
    required this.estado,
    required this.myColor,
    required this.otherColor,
    this.estadoColor = Colors.white,
  });

  String get _horaFormateada {
    return DateFormat('h:mm a', 'es')
        .format(fecha)
        .toLowerCase()
        .replaceAll('am', 'a. m.')
        .replaceAll('pm', 'p. m.');
  }

  String get _emojiEstado {
    switch (estado) {
      case 'PENDIENTE':
        return '🕓 Pendiente';
      case 'ENVIADO':
        return '📤 Enviado';
      case 'ENTREGADO':
        return '📬 Entregado';
      case 'LEIDO':
        return '✅ Leído';
      case 'ERROR_ENVIO':
        return '❌ Error';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final alignment = esMio ? Alignment.centerRight : Alignment.centerLeft;
    final bgColor = esMio ? myColor : otherColor;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(esMio ? 12 : 0),
            bottomRight: Radius.circular(esMio ? 0 : 12),
          ),
        ),
        child: Column(
          crossAxisAlignment:
          esMio ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Imagen se ajusta automáticamente al ancho disponible
            ImagenDesdeBlocWidget(
              fileName: nombreArchivo,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _horaFormateada,
                  style: TextStyle(fontSize: 10, color: estadoColor),
                ),
                if (esMio) ...[
                  const SizedBox(width: 6),
                  Text(
                    _emojiEstado,
                    style: TextStyle(fontSize: 10, color: estadoColor),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}