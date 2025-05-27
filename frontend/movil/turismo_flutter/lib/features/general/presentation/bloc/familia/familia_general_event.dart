import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_dto.dart';

class FamiliaGeneralEvent extends Equatable{
  const FamiliaGeneralEvent();

  @override
  List<Object?> get props => [];
}

class GetFamiliasEventGeneral extends FamiliaGeneralEvent{}

class GetFamiliaByIdEventGeneral extends FamiliaGeneralEvent{
  final int idFamilia;
  const GetFamiliaByIdEventGeneral(this.idFamilia);

  @override
  List<Object?> get props => [idFamilia];
}

class BuscarFamiliasPorNombreEventGeneral extends FamiliaGeneralEvent {
  final String nombre;

  const BuscarFamiliasPorNombreEventGeneral(this.nombre);

  @override
  List<Object?> get props => [nombre];
}