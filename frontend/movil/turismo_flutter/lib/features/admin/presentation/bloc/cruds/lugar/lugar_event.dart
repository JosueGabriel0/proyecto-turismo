import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';

abstract class LugarEvent extends Equatable{
  const LugarEvent();

  @override
  List<Object?> get props => [];
}

class GetAllLugaresEvent extends LugarEvent{}

class GetLugarByIdEvent extends LugarEvent{
  final int id;
  const GetLugarByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class PostLugarEvent extends LugarEvent{
  final LugarDto lugarDto;
  final File? imagen;
  const PostLugarEvent(this.lugarDto, this.imagen);

  @override
  List<Object?> get props => [lugarDto, imagen];
}

class PutLugarEvent extends LugarEvent{
  final int id;
  final LugarDto lugarDto;
  final File? imagen;
  const PutLugarEvent(this.id, this.lugarDto, this.imagen);

  @override
  List<Object?> get props => [id,lugarDto,imagen];
}

class DeleteLugarEvent extends LugarEvent{
  final int id;
  const DeleteLugarEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class BuscarLugaresPorNombreEvent extends LugarEvent {
  final String nombre;

  const BuscarLugaresPorNombreEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}