import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/chat_resumen_dto.dart';
import 'package:turismo_flutter/features/chat/data/models/mensaje_dto.dart';

abstract class MensajeAdminState extends Equatable {
  const MensajeAdminState();

  @override
  List<Object?> get props => [];
}

class MensajeAdminInitial extends MensajeAdminState {}

class MensajeAdminLoading extends MensajeAdminState {}

class ChatsRecientesCargados extends MensajeAdminState {
  final List<ChatResumenDto> chats;

  const ChatsRecientesCargados(this.chats);

  @override
  List<Object?> get props => [chats];
}

class HistorialCargado extends MensajeAdminState {
  final List<MensajeDto> mensajes;

  const HistorialCargado(this.mensajes);

  @override
  List<Object?> get props => [mensajes];
}

class MensajeAdminError extends MensajeAdminState {
  final String mensaje;

  const MensajeAdminError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}