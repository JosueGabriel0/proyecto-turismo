class ReservaDetalleGeneralResponse {
  int idReservaDetalle;
  String descripcion;
  double precio;
  String? fechaCreacionReservaDetalle;
  String? fechaModificacionReservaDetalle;

  ReservaDetalleGeneralResponse({
    required this.idReservaDetalle,
    required this.descripcion,
    required this.precio,
    this.fechaCreacionReservaDetalle,
    this.fechaModificacionReservaDetalle,
  });

  factory ReservaDetalleGeneralResponse.fromJson(Map<String, dynamic> json) {
    return ReservaDetalleGeneralResponse(
      idReservaDetalle: json['idReservaDetalle'],
      descripcion: json['descripcion'],
      precio: json['precio'].toDouble(),
      fechaCreacionReservaDetalle: json['fechaCreacionReservaDetalle'],
      fechaModificacionReservaDetalle: json['fechaModificacionReservaDetalle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idReservaDetalle': idReservaDetalle,
      'descripcion': descripcion,
      'precio': precio,
      'fechaCreacionReservaDetalle': fechaCreacionReservaDetalle,
      'fechaModificacionReservaDetalle': fechaModificacionReservaDetalle,
    };
  }
}