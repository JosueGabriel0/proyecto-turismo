import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_dto.dart';

class FamiliaEvent extends Equatable{
  const FamiliaEvent();

  @override
  List<Object?> get props => [];
}

class GetFamiliasEvent extends FamiliaEvent{}

class GetFamiliaByIdEvent extends FamiliaEvent{
  final int idFamilia;
  const GetFamiliaByIdEvent(this.idFamilia);

  @override
  List<Object?> get props => [idFamilia];
}

class PostFamiliaEvent extends FamiliaEvent{
  final FamiliaDto familiaDto;
  final File? file;
  const PostFamiliaEvent(this.familiaDto, this.file);

  @override
  List<Object?> get props => [familiaDto, file];
}

class PutFamiliaEvent extends FamiliaEvent{
  final int idFamilia;
  final FamiliaDto familiaDto;
  final File? file;

  const PutFamiliaEvent(this.idFamilia, this.familiaDto, this.file);

  @override
  List<Object?> get props => [idFamilia, familiaDto, file];
}

class DeleteFamiliaEvent extends FamiliaEvent{
  final int idFamilia;
  DeleteFamiliaEvent(this.idFamilia);

  @override
  List<Object?> get props => [idFamilia];
}

class BuscarFamiliasPorNombreEvent extends FamiliaEvent {
  final String nombre;

  const BuscarFamiliasPorNombreEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}