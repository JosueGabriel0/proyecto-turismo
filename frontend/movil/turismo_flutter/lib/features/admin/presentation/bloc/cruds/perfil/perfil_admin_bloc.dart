import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuario_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/update_usuario_usecase.dart';
import 'perfil_admin_event.dart';
import 'perfil_admin_state.dart';

class PerfilAdminBloc extends Bloc<PerfilAdminEvent, PerfilAdminState> {
  final GetUsuarioByIdUseCase getUsuarioByIdUseCase;
  final UpdateUsuarioUseCase updateUsuarioUseCase;
  final TokenStorageService tokenStorageService;

  PerfilAdminBloc({
    required this.getUsuarioByIdUseCase,
    required this.updateUsuarioUseCase,
    required this.tokenStorageService,
  }) : super(PerfilAdminInitial()) {
    on<LoadPerfilAdminEvent>(_onLoadPerfilAdmin);
    on<UpdatePerfilAdminEvent>(_onUpdatePerfilAdmin);
  }

  Future<void> _onLoadPerfilAdmin(
      LoadPerfilAdminEvent event,
      Emitter<PerfilAdminState> emit,
      ) async {
    emit(PerfilAdminLoading());
    try {
      final token = await tokenStorageService.getToken();
      final id = getIdUsuarioFromToken(token!);
      if (id == null) throw Exception("ID de usuario inválido");

      final usuario = await getUsuarioByIdUseCase(id);
      emit(PerfilAdminLoaded(usuario));
    } catch (e) {
      emit(PerfilAdminError("Error al cargar el perfil: $e"));
    }
  }

  Future<void> _onUpdatePerfilAdmin(
      UpdatePerfilAdminEvent event,
      Emitter<PerfilAdminState> emit,
      ) async {
    emit(PerfilAdminLoading());
    try {
      final token = await tokenStorageService.getToken();
      final id = getIdUsuarioFromToken(token!);
      if (id == null) throw Exception("ID de usuario inválido");

      await updateUsuarioUseCase(id, event.usuario, event.imagen);
      final usuarioActualizado = await getUsuarioByIdUseCase(id);
      emit(PerfilAdminLoaded(usuarioActualizado));
    } catch (e) {
      emit(PerfilAdminError("Error al actualizar el perfil: $e"));
    }
  }
}