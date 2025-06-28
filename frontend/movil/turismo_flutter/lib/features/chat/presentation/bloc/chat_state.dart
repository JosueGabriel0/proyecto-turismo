import 'package:equatable/equatable.dart';
import '../../domain/entities/mensaje.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatConnected extends ChatState {}

class ChatDisconnected extends ChatState {}

class ChatMensajeEnviado extends ChatState {
  final Mensaje mensaje;
  const ChatMensajeEnviado(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}

class ChatMensajeEditado extends ChatState {
  final Mensaje mensaje;
  const ChatMensajeEditado(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}

class ChatMensajeRecibido extends ChatState {
  final Mensaje mensaje;
  const ChatMensajeRecibido(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}

class ChatEstadoMensajeActualizado extends ChatState {
  final Mensaje mensaje;
  const ChatEstadoMensajeActualizado(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}

class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatMensajesEstado extends ChatState {
  final List<Mensaje> mensajes;

  const ChatMensajesEstado(this.mensajes);

  @override
  List<Object?> get props => [mensajes];
}