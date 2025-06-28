import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/general/data/models/ubicacion_dto.dart';

abstract class UbicacionState extends Equatable {
  const UbicacionState();

  @override
  List<Object?> get props => [];
}

class UbicacionInitial extends UbicacionState {}

class UbicacionLoading extends UbicacionState {}

class UbicacionLoaded extends UbicacionState {
  final List<UbicacionDto> ubicaciones;

  const UbicacionLoaded(this.ubicaciones);

  @override
  List<Object?> get props => [ubicaciones];
}

class UbicacionError extends UbicacionState {
  final String mensaje;

  const UbicacionError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}