import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/data/models/reserva_response.dart';

class EmprendimientoResponse {
  int idEmprendimiento;
  String nombre;
  String descripcion;
  String imagenUrl;
  CategoriaResponse categoria;
  String familia;
  List<Reserva> reservas;
  DateTime fechaCreacionEmprendimiento;
  DateTime fechaModificacionEmprendimiento;

  EmprendimientoResponse({
    required this.idEmprendimiento,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.categoria,
    required this.familia,
    required this.reservas,
    required this.fechaCreacionEmprendimiento,
    required this.fechaModificacionEmprendimiento,
  });

  factory EmprendimientoResponse.fromJson(Map<String, dynamic> json) {
    return EmprendimientoResponse(
      idEmprendimiento: json['idEmprendimiento'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: json['imagenUrl'],
      categoria: CategoriaResponse.fromJson(json['categoria']),
      familia: json['familia'],
      reservas: (json['reservas'] as List)
          .map((e) => Reserva.fromJson(e))
          .toList(),
      fechaCreacionEmprendimiento:
      DateTime.parse(json['fechaCreacionEmprendimiento']),
      fechaModificacionEmprendimiento:
      DateTime.parse(json['fechaModificacionEmprendimiento']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idEmprendimiento': idEmprendimiento,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'categoria': categoria.toJson(),
      'familia': familia,
      'reservas': reservas.map((e) => e.toJson()).toList(),
      'fechaCreacionEmprendimiento':
      fechaCreacionEmprendimiento.toIso8601String(),
      'fechaModificacionEmprendimiento':
      fechaModificacionEmprendimiento.toIso8601String(),
    };
  }
}
