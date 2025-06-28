class ChatResumenDto {
  String? username;
  String? nombreCompleto;
  String? ultimoMensaje;
  DateTime? hora;
  String? avatarUrl;
  String? estadoUltimoMensaje;

  ChatResumenDto({
    this.username,
    this.nombreCompleto,
    this.ultimoMensaje,
    this.hora,
    this.avatarUrl,
    this.estadoUltimoMensaje,
  });

  factory ChatResumenDto.fromJson(Map<String, dynamic> json) {
    return ChatResumenDto(
      username: json['username'],
      nombreCompleto: json['nombreCompleto'],
      ultimoMensaje: json['ultimoMensaje'],
      hora: json['hora'] != null ? DateTime.parse(json['hora']) : null,
      avatarUrl: json['avatarUrl'],
      estadoUltimoMensaje: json['estadoUltimoMensaje'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'nombreCompleto': nombreCompleto,
      'ultimoMensaje': ultimoMensaje,
      'hora': hora?.toIso8601String(),
      'avatarUrl': avatarUrl,
      'estadoUltimoMensaje': estadoUltimoMensaje,
    };
  }
}