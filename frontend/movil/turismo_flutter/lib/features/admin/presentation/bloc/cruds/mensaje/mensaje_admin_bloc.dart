import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/mensaje/obtener_chats_recientes_admin_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/mensaje/obtener_historial_admin_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/mensaje/mensaje_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/mensaje/mensaje_admin_state.dart';

class MensajeAdminBloc extends Bloc<MensajeAdminEvent, MensajeAdminState> {
  final ObtenerChatsRecientesAdminUsecase obtenerChatsRecientes;
  final ObtenerHistorialAdminUsecase obtenerHistorial;

  MensajeAdminBloc({
    required this.obtenerChatsRecientes,
    required this.obtenerHistorial,
  }) : super(MensajeAdminInitial()) {
    on<ObtenerChatsRecientesEvent>(_onObtenerChatsRecientes);
    on<ObtenerHistorialEvent>(_onObtenerHistorial);
  }

  Future<void> _onObtenerChatsRecientes(
      ObtenerChatsRecientesEvent event, Emitter<MensajeAdminState> emit) async {
    emit(MensajeAdminLoading());
    try {
      final chats = await obtenerChatsRecientes();
      emit(ChatsRecientesCargados(chats));
    } catch (e) {
      emit(MensajeAdminError('Error al cargar chats recientes: $e'));
    }
  }

  Future<void> _onObtenerHistorial(
      ObtenerHistorialEvent event, Emitter<MensajeAdminState> emit) async {
    emit(MensajeAdminLoading());
    try {
      final historial = await obtenerHistorial(event.usuarioId);
      emit(HistorialCargado(historial));
    } catch (e) {
      emit(MensajeAdminError('Error al cargar historial: $e'));
    }
  }
}