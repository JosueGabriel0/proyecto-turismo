class ServicioTuristicoResponse {
  final int idServicio;
  final String nombre;
  final String descripcion;
  final double precioUnitario;
  final String tipoServicio; // Puedes usar un enum si lo prefieres
  final String? imagenUrl;
  final DateTime fechaCreacion;
  final DateTime? fechaModificacion;

  ServicioTuristicoResponse({
    required this.idServicio,
    required this.nombre,
    required this.descripcion,
    required this.precioUnitario,
    required this.tipoServicio,
    required this.imagenUrl,
    required this.fechaCreacion,
    this.fechaModificacion,
  });

  factory ServicioTuristicoResponse.fromJson(Map<String, dynamic> json) {
    return ServicioTuristicoResponse(
      idServicio: json['idServicio'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precioUnitario: (json['precioUnitario'] as num).toDouble(),
      tipoServicio: json['tipoServicio'],
      imagenUrl: json['imagenUrl'],
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
      fechaModificacion: json['fechaModificacion'] != null
          ? DateTime.tryParse(json['fechaModificacion'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idServicio': idServicio,
      'nombre': nombre,
      'descripcion': descripcion,
      'precioUnitario': precioUnitario,
      'tipoServicio': tipoServicio,
      'imagenUrl': imagenUrl,
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaModificacion': fechaModificacion?.toIso8601String(),
    };
  }
}