class MensajeDto {
  final int? id;
  final String emisorUsername;
  final String receptorUsername;
  final String? contenidoTexto;
  final String? contenidoArchivo;
  final String tipo; // Ej: "TEXTO", "IMAGEN", "AUDIO"
  final String? estado; // Ej: "ENVIADO", "LEIDO", "ERROR_ENVIO"
  final bool editado;
  final DateTime? fechaEnvio;

  MensajeDto({
    this.id,
    required this.emisorUsername,
    required this.receptorUsername,
    this.contenidoTexto,
    this.contenidoArchivo,
    required this.tipo,
    this.estado,
    this.editado = false,
    this.fechaEnvio,
  });

  factory MensajeDto.fromJson(Map<String, dynamic> json) {
    return MensajeDto(
      id: json['id'],
      emisorUsername: json['emisorUsername'],
      receptorUsername: json['receptorUsername'],
      contenidoTexto: json['contenidoTexto'],
      contenidoArchivo: json['contenidoArchivo'],
      tipo: json['tipo'] ?? 'TEXTO', // default a "TEXTO" si falta
      estado: json['estado'],
      editado: json['editado'] ?? false,
      fechaEnvio: json['fechaEnvio'] != null
          ? DateTime.tryParse(json['fechaEnvio'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'emisorUsername': emisorUsername,
      'receptorUsername': receptorUsername,
      'contenidoTexto': contenidoTexto,
      'contenidoArchivo': contenidoArchivo,
      'tipo': tipo,
      'estado': estado,
      'editado': editado,
      'fechaEnvio': fechaEnvio?.toIso8601String(),
    };
  }
}