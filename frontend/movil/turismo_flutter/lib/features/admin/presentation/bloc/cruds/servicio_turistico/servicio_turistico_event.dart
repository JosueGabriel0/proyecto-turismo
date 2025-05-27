import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_dto.dart';

abstract class ServicioTuristicoEvent extends Equatable{
  const ServicioTuristicoEvent();

  @override
  List<Object?> get props => [];
}

class GetAllServiciosTuristicosEvent extends ServicioTuristicoEvent{}

class GetServicioTuristicoByIdEvent extends ServicioTuristicoEvent{
  final int id;
  const GetServicioTuristicoByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class PostServicioTuristicoEvent extends ServicioTuristicoEvent{
  final ServicioTuristicoDto servicioTuristicoDto;
  final File? imagen;
  const PostServicioTuristicoEvent(this.servicioTuristicoDto, this.imagen);

  @override
  List<Object?> get props => [servicioTuristicoDto, imagen];
}

class PutServicioTuristicoEvent extends ServicioTuristicoEvent{
  final int id;
  final ServicioTuristicoDto servicioTuristicoDto;
  final File? imagen;
  const PutServicioTuristicoEvent(this.id, this.servicioTuristicoDto, this.imagen);

  @override
  List<Object?> get props => [id,servicioTuristicoDto,imagen];
}

class DeleteServicioTuristicoEvent extends ServicioTuristicoEvent{
  final int id;
  const DeleteServicioTuristicoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class BuscarServiciosTuristicosPorNombreEvent extends ServicioTuristicoEvent {
  final String nombre;

  const BuscarServiciosTuristicosPorNombreEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}