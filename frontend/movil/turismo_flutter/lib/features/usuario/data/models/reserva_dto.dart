import 'package:turismo_flutter/features/usuario/data/models/reserva_detalle_dto.dart';

class ReservaDto {
  final int idEmprendimiento;
  final DateTime fechaHoraInicio;
  final DateTime fechaHoraFin;
  final List<ReservaDetalleDto> detalles;

  ReservaDto({
    required this.idEmprendimiento,
    required this.fechaHoraInicio,
    required this.fechaHoraFin,
    required this.detalles,
  });

  factory ReservaDto.fromJson(Map<String, dynamic> json) {
    return ReservaDto(
      idEmprendimiento: json['idEmprendimiento'],
      fechaHoraInicio: DateTime.parse(json['fechaHoraInicio']),
      fechaHoraFin: DateTime.parse(json['fechaHoraFin']),
      detalles: (json['detalles'] as List?)?.map((item) => ReservaDetalleDto.fromJson(item)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idEmprendimiento': idEmprendimiento,
      'fechaHoraInicio': fechaHoraInicio.toIso8601String().split('.').first,
      'fechaHoraFin': fechaHoraFin.toIso8601String().split('.').first,
      'detalles': detalles.map((item) => item.toJson()).toList(),
    };
  }
}