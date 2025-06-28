import 'package:equatable/equatable.dart';

abstract class UbicacionEvent extends Equatable {
  const UbicacionEvent();

  @override
  List<Object> get props => [];
}

class ObtenerUbicacionesEvent extends UbicacionEvent {}