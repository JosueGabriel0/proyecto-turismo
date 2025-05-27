import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_categoria_general_dto_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_categoria_general_response.dart';

class FamiliaCategoriaGeneralState extends Equatable {
  const FamiliaCategoriaGeneralState();

  @override
  List<Object?> get props => [];
}

class FamiliaCategoriaInitialGeneral extends FamiliaCategoriaGeneralState {}
class FamiliaCategoriaLoadingGeneral extends FamiliaCategoriaGeneralState {}

class FamiliaCategoriaLoadedGeneral extends FamiliaCategoriaGeneralState {
  final FamiliaCategoriaGeneralResponse familiaCategoriaGeneralResponse;

  const FamiliaCategoriaLoadedGeneral(this.familiaCategoriaGeneralResponse);
  @override
  List<Object?> get props => [familiaCategoriaGeneralResponse];
}

class FamiliaCategoriaListLoadedGeneral extends FamiliaCategoriaGeneralState {
  final List<FamiliaCategoriaGeneralDtoResponse> familiaCategoriaGeneralListResponse;

  const FamiliaCategoriaListLoadedGeneral(this.familiaCategoriaGeneralListResponse);
  @override
  List<Object?> get props => [familiaCategoriaGeneralListResponse];
}

class FamiliaCategoriaSuccessGeneral extends FamiliaCategoriaGeneralState {
  final String message;

  const FamiliaCategoriaSuccessGeneral(this.message);
  @override
  List<Object?> get props => [message];
}

class FamiliaCategoriaErrorGeneral extends FamiliaCategoriaGeneralState {
  final String message;

  const FamiliaCategoriaErrorGeneral(this.message);
  @override
  List<Object?> get props => [message];
}

class EmprendimientosPorFamiliaCategoriaLoadedGeneral extends FamiliaCategoriaGeneralState {
  final List<EmprendimientoGeneralResponse> emprendimientos;

  const EmprendimientosPorFamiliaCategoriaLoadedGeneral(this.emprendimientos);

  @override
  List<Object?> get props => [emprendimientos];
}