import 'package:equatable/equatable.dart';
import '../../domain/entities/mensaje.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ConectarChatEvent extends ChatEvent {}

class DesconectarChatEvent extends ChatEvent {}

class EnviarMensajeEvent extends ChatEvent {
  final Mensaje mensaje;
  const EnviarMensajeEvent(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}

class EditarMensajeEvent extends ChatEvent {
  final Mensaje mensaje;
  const EditarMensajeEvent(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}

class MarcarComoEntregadoEvent extends ChatEvent {
  final String emisor;
  final String receptor;
  const MarcarComoEntregadoEvent(this.emisor, this.receptor);

  @override
  List<Object?> get props => [emisor, receptor];
}

class MarcarComoLeidoEvent extends ChatEvent {
  final String emisor;
  final String receptor;
  const MarcarComoLeidoEvent(this.emisor, this.receptor);

  @override
  List<Object?> get props => [emisor, receptor];
}

class MensajeRecibidoEvent extends ChatEvent {
  final Mensaje mensaje;
  const MensajeRecibidoEvent(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}

class EstadoMensajeActualizadoEvent extends ChatEvent {
  final Mensaje mensaje;
  const EstadoMensajeActualizadoEvent(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}

class MensajeEditadoRecibidoEvent extends ChatEvent {
  final Mensaje mensaje;
  const MensajeEditadoRecibidoEvent(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}