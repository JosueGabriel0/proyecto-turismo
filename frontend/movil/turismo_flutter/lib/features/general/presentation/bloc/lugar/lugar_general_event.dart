import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';

abstract class LugarGeneralEvent extends Equatable{
  const LugarGeneralEvent();

  @override
  List<Object?> get props => [];
}

class GetAllLugaresGeneralEvent extends LugarGeneralEvent{}

class BuscarLugaresPorNombreGeneralEvent extends LugarGeneralEvent {
  final String nombre;

  const BuscarLugaresPorNombreGeneralEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}

class GetFamiliasPorLugarEvent extends LugarGeneralEvent {
  final int idLugar;
  final String? nombre;

  const GetFamiliasPorLugarEvent(this.idLugar, {this.nombre});

  @override
  List<Object?> get props => [idLugar, nombre];
}
