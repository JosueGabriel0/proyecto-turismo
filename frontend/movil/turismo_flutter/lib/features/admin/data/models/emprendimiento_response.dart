import 'package:turismo_flutter/features/admin/data/models/reserva_response.dart';

class EmprendimientoResponse {
  int idEmprendimiento;
  String nombre;
  String descripcion;
  String? imagenUrl;
  String latitud;
  String longitud;
  List<ReservaResponse>? reservas; // Ahora puede ser null
  String fechaCreacionEmprendimiento;
  String? fechaModificacionEmprendimiento;

  EmprendimientoResponse({
    required this.idEmprendimiento,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.latitud,
    required this.longitud,
    this.reservas,
    required this.fechaCreacionEmprendimiento,
    this.fechaModificacionEmprendimiento,
  });

  factory EmprendimientoResponse.fromJson(Map<String, dynamic> json) {
    return EmprendimientoResponse(
      idEmprendimiento: json['idEmprendimiento'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: json['imagenUrl'],
      latitud: json['latitud'].toString(),
      longitud: json['longitud'].toString(),
      reservas: json['reservas'] != null
          ? (json['reservas'] as List<dynamic>)
          .map((e) => ReservaResponse.fromJson(e as Map<String, dynamic>))
          .toList()
          : null,
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
      'reservas': reservas,
      'fechaCreacionEmprendimiento': fechaCreacionEmprendimiento,
      'fechaModificacionEmprendimiento': fechaModificacionEmprendimiento,
    };
  }
}