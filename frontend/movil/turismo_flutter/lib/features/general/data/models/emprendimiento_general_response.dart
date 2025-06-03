import 'package:turismo_flutter/features/general/data/models/reserva_general_response.dart';

class EmprendimientoGeneralResponse {
  int idEmprendimiento;
  String nombre;
  String descripcion;
  String? imagenUrl;
  String latitud;
  String longitud;
  List<ReservaGeneralResponse>? reservas; // Ahora puede ser null
  String fechaCreacionEmprendimiento;
  String? fechaModificacionEmprendimiento;

  EmprendimientoGeneralResponse({
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

  factory EmprendimientoGeneralResponse.fromJson(Map<String, dynamic> json) {
    return EmprendimientoGeneralResponse(
      idEmprendimiento: json['idEmprendimiento'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: json['imagenUrl'],
      latitud: json['latitud'].toString(),
      longitud: json['longitud'].toString(),
      reservas: json['reservas'] != null
          ? (json['reservas'] as List)
          .map((e) => ReservaGeneralResponse.fromJson(e))
          .toList()
          : [],
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