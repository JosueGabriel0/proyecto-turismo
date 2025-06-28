import 'package:turismo_flutter/features/chat/data/models/mensaje_dto.dart';

import '../../domain/entities/mensaje.dart';

extension MensajeDtoMapper on MensajeDto {
  Mensaje? toEntity() {
    // Validación simple: si no tiene id ni tipo, retorna null
    if ((id == null) && (tipo == null || tipo!.isEmpty)) {
      print('⚠️ MensajeDto inválido: id=$id, tipo=$tipo');
      return null;
    }
    return Mensaje(
      id: id,
      emisor: emisorUsername,
      receptor: receptorUsername,
      texto: contenidoTexto,
      archivo: contenidoArchivo,
      tipo: tipo,
      estado: estado,
      editado: editado,
      fecha: fechaEnvio,
    );
  }
}

extension MensajeEntityMapper on Mensaje {
  MensajeDto toDto() {
    return MensajeDto(
      id: id,
      emisorUsername: emisor,
      receptorUsername: receptor,
      contenidoTexto: texto,
      contenidoArchivo: archivo,
      tipo: tipo,
      estado: estado,
      editado: editado,
      fechaEnvio: fecha,
    );
  }
}