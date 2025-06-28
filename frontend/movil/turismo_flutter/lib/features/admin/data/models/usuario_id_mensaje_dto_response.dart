class UsuarioIdMensajeDtoResponse {
  final int usuarioId;

  UsuarioIdMensajeDtoResponse({required this.usuarioId});

  factory UsuarioIdMensajeDtoResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioIdMensajeDtoResponse(
      usuarioId: json['usuarioId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
    };
  }
}