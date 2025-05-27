import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';
import 'package:turismo_flutter/features/general/data/models/lugar_general_response.dart';

abstract class LugarGeneralState extends Equatable{
  const LugarGeneralState();

  @override
  List<Object?> get props => [];
}

class LugarInitialGeneral extends LugarGeneralState{}

class LugarLoadingGeneral extends LugarGeneralState{}

class LugarListLoadedGeneral extends LugarGeneralState{
  final List<LugarGeneralResponse> lugares;
  const LugarListLoadedGeneral(this.lugares);

  @override
  List<Object?> get props => [lugares];
}

class LugarSuccessGeneral extends LugarGeneralState{
  final String message;
  const LugarSuccessGeneral(this.message);

  @override
  List<Object?> get props => [message];
}

class LugarErrorGeneral extends LugarGeneralState{
  final String message;
  const LugarErrorGeneral(this.message);

  @override
  List<Object?> get props => [message];
}

class LugarSearchLoadedGeneral extends LugarGeneralState {
  final List<LugarGeneralResponse> resultados;

  const LugarSearchLoadedGeneral(this.resultados);

  @override
  List<Object?> get props => [resultados];
}

class FamiliasPorLugarLoadedGeneral extends LugarGeneralState {
  final List<FamiliaGeneralResponse> familias;

  const FamiliasPorLugarLoadedGeneral(this.familias);

  @override
  List<Object?> get props => [familias];
}
