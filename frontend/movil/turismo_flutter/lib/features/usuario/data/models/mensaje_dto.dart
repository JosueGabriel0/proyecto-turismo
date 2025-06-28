class MensajeDto {
  int? id;
  String? emisorUsername;
  String? receptorUsername;
  String? contenidoTexto;
  String? contenidoArchivo;
  String? tipo;
  String? estado;
  bool editado;
  DateTime? fechaEnvio;

  MensajeDto({
    this.id,
    this.emisorUsername,
    this.receptorUsername,
    this.contenidoTexto,
    this.contenidoArchivo,
    this.tipo,
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
      tipo: json['tipo'],
      estado: json['estado'],
      editado: json['editado'] ?? false,
      fechaEnvio: json['fechaEnvio'] != null
          ? DateTime.parse(json['fechaEnvio'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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