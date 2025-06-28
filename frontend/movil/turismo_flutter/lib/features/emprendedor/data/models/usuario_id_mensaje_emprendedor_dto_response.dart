class UsuarioIdMensajeEmprendedorDtoResponse {
  final int usuarioId;

  UsuarioIdMensajeEmprendedorDtoResponse({required this.usuarioId});

  factory UsuarioIdMensajeEmprendedorDtoResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioIdMensajeEmprendedorDtoResponse(
      usuarioId: json['usuarioId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
    };
  }
}