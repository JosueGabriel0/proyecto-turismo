
class ReservaDetalleDto {
  final int idServicioTuristico;
  final int cantidad;
  final String observaciones;

  ReservaDetalleDto({
    required this.idServicioTuristico,
    required this.cantidad,
    required this.observaciones,
  });

  factory ReservaDetalleDto.fromJson(Map<String, dynamic> json) {
    return ReservaDetalleDto(
      idServicioTuristico: json['idServicioTuristico'],
      cantidad: json['cantidad'],
      observaciones: json['observaciones'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idServicioTuristico': idServicioTuristico,
      'cantidad': cantidad,
      'observaciones': observaciones,
    };
  }
}