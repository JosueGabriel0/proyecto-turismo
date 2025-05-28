import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_dto.dart';

abstract class ServicioTuristicoEmprendedorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BuscarServiciosPorNombreEmprendedorEvent extends ServicioTuristicoEmprendedorEvent {
  final String nombre;
  BuscarServiciosPorNombreEmprendedorEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}

class EliminarServicioTuristicoEmprendedorEvent extends ServicioTuristicoEmprendedorEvent {
  final int idServicio;
  EliminarServicioTuristicoEmprendedorEvent(this.idServicio);

  @override
  List<Object?> get props => [idServicio];
}

class ObtenerServicioPorIdEmprendedorEvent extends ServicioTuristicoEmprendedorEvent {
  final int idServicio;
  ObtenerServicioPorIdEmprendedorEvent(this.idServicio);

  @override
  List<Object?> get props => [idServicio];
}

class ObtenerServiciosPorIdEmprendimientoEmprendedorEvent extends ServicioTuristicoEmprendedorEvent {
  final int idEmprendimiento;
  ObtenerServiciosPorIdEmprendimientoEmprendedorEvent(this.idEmprendimiento);

  @override
  List<Object?> get props => [idEmprendimiento];
}

class CrearServicioTuristicoEmprendedorEvent extends ServicioTuristicoEmprendedorEvent {
  final ServicioTuristicoEmprendedorDto dto;
  final File? file;
  CrearServicioTuristicoEmprendedorEvent(this.dto, this.file);

  @override
  List<Object?> get props => [dto, file];
}

class ActualizarServicioTuristicoEmprendedorEvent extends ServicioTuristicoEmprendedorEvent {
  final int idServicio;
  final ServicioTuristicoEmprendedorDto dto;
  final File? file;
  ActualizarServicioTuristicoEmprendedorEvent(this.idServicio, this.dto, this.file);

  @override
  List<Object?> get props => [idServicio, dto, file];
}
