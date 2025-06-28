class UsuarioIdMensajeUsuarioDtoResponse {
  final int usuarioId;

  UsuarioIdMensajeUsuarioDtoResponse({required this.usuarioId});

  factory UsuarioIdMensajeUsuarioDtoResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioIdMensajeUsuarioDtoResponse(
      usuarioId: json['usuarioId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
    };
  }
}