import 'package:equatable/equatable.dart';

abstract class MensajeAdminEvent extends Equatable {
  const MensajeAdminEvent();

  @override
  List<Object?> get props => [];
}

class ObtenerChatsRecientesEvent extends MensajeAdminEvent {}

class ObtenerHistorialEvent extends MensajeAdminEvent {
  final int usuarioId;

  const ObtenerHistorialEvent(this.usuarioId);

  @override
  List<Object?> get props => [usuarioId];
}