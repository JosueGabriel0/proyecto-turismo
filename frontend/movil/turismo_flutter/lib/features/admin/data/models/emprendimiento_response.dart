class EmprendimientoResponse {
  int idEmprendimiento;
  String nombre;
  String descripcion;
  String imagenUrl;
  double latitud;
  double longitud;
  String fechaCreacionEmprendimiento;
  String? fechaModificacionEmprendimiento;

  EmprendimientoResponse({
    required this.idEmprendimiento,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.latitud,
    required this.longitud,
    required this.fechaCreacionEmprendimiento,
    this.fechaModificacionEmprendimiento,
  });

  factory EmprendimientoResponse.fromJson(Map<String, dynamic> json) {
    return EmprendimientoResponse(
      idEmprendimiento: json['idEmprendimiento'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: json['imagenUrl'],
      latitud: json['latitud']?.toDouble(),
      longitud: json['longitud']?.toDouble(),
      fechaCreacionEmprendimiento: json['fechaCreacionEmprendimiento'],
      fechaModificacionEmprendimiento: json['fechaModificacionEmprendimiento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idEmprendimiento': idEmprendimiento,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'latitud': latitud,
      'longitud': longitud,
      'fechaCreacionEmprendimiento': fechaCreacionEmprendimiento,
      'fechaModificacionEmprendimiento': fechaModificacionEmprendimiento,
    };
  }
}