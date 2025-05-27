import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';

class FamiliaGeneralState extends Equatable {
  const FamiliaGeneralState();

  @override
  List<Object?> get props => [];
}

class FamiliaInitialGeneral extends FamiliaGeneralState {}
class FamiliaLoadingGeneral extends FamiliaGeneralState {}

class FamiliaLoadedGeneral extends FamiliaGeneralState {
  final FamiliaGeneralResponse familiaResponse;
  const FamiliaLoadedGeneral(this.familiaResponse);

  @override
  List<Object?> get props => [familiaResponse];
}

class FamiliaListLoadedGeneral extends FamiliaGeneralState {
  final List<FamiliaGeneralResponse> familiaListResponse;
  const FamiliaListLoadedGeneral(this.familiaListResponse);

  @override
  List<Object?> get props => [familiaListResponse];
}

class FamiliaSuccessGeneral extends FamiliaGeneralState {
  final String message;
  const FamiliaSuccessGeneral(this.message);

  @override
  List<Object?> get props => [message];
}

class FamiliaErrorGeneral extends FamiliaGeneralState {
  final String message;
  const FamiliaErrorGeneral(this.message);

  @override
  List<Object?> get props => [message];
}

class FamiliaSearchLoadedGeneral extends FamiliaGeneralState {
  final List<FamiliaGeneralResponse> resultados;

  const FamiliaSearchLoadedGeneral(this.resultados);

  @override
  List<Object?> get props => [resultados];
}