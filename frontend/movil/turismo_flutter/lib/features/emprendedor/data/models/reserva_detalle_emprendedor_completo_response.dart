class ReservaDetalleEmprendedorCompletoResponse {
  final int idReservaDetalle;
  final String descripcion;
  final int? cantidad;
  final double? precioUnitario;
  final double? total;
  final String? tipoServicio;
  final String? observaciones;
  final DateTime? fechaCreacionReservaDetalle;
  final DateTime? fechaModificacionReservaDetalle;

  ReservaDetalleEmprendedorCompletoResponse({
    required this.idReservaDetalle,
    required this.descripcion,
    this.cantidad,
    this.precioUnitario,
    this.total,
    this.tipoServicio,
    this.observaciones,
    this.fechaCreacionReservaDetalle,
    this.fechaModificacionReservaDetalle,
  });

  factory ReservaDetalleEmprendedorCompletoResponse.fromJson(Map<String, dynamic> json) {
    return ReservaDetalleEmprendedorCompletoResponse(
      idReservaDetalle: json['idReservaDetalle'],
      descripcion: json['descripcion'],
      cantidad: json['cantidad'],
      precioUnitario: (json['precioUnitario'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      tipoServicio: json['tipoServicio'],
      observaciones: json['observaciones'],
      fechaCreacionReservaDetalle: json['fechaCreacionReservaDetalle'] != null
          ? DateTime.parse(json['fechaCreacionReservaDetalle'])
          : null,
      fechaModificacionReservaDetalle: json['fechaModificacionReservaDetalle'] != null
          ? DateTime.parse(json['fechaModificacionReservaDetalle'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idReservaDetalle': idReservaDetalle,
      'descripcion': descripcion,
      'cantidad': cantidad,
      'precioUnitario': precioUnitario,
      'total': total,
      'tipoServicio': tipoServicio,
      'observaciones': observaciones,
      'fechaCreacionReservaDetalle': fechaCreacionReservaDetalle?.toIso8601String(),
      'fechaModificacionReservaDetalle': fechaModificacionReservaDetalle?.toIso8601String(),
    };
  }
}