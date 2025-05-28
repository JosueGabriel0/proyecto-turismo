import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/usuario/get_usuario_by_id_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/usuario/put_usuario_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/usuario/usuario_emprendedor_event.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/usuario/usuario_emprendedor_state.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/usuario/get_usuario_by_id_user_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/usuario/put_usuario_user_usecase.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_state.dart';

class UsuarioEmprendedorBloc extends Bloc<UsuarioEmprendedorEvent, UsuarioEmprendedorState> {
  final GetUsuarioByIdEmprendedorUsecase getUsuarioByIdEmprendedorUsecase;
  final PutUsuarioEmprendedorUsecase putUsuarioEmprendedorUsecase;
  final TokenStorageService tokenStorageService;

  UsuarioEmprendedorBloc({
    required this.getUsuarioByIdEmprendedorUsecase,
    required this.putUsuarioEmprendedorUsecase,
    required this.tokenStorageService,
  }) : super(UsuarioEmprendedorInitial()) {

    on<GetUsuarioByIdEmprendedorEvent>((event, emit) async {
      emit(UsuarioEmprendedorLoading());
      try {
        final usuario = await getUsuarioByIdEmprendedorUsecase(event.id);
        emit(UsuarioEmprendedorProfileLoaded(usuario));
      } catch (e) {
        emit(UsuarioEmprendedorError("Error al obtener usuario: $e"));
      }
    });

    on<PutUsuarioEmprendedorEvent>((event, emit) async {
      print("Evento llamado");
      emit(UsuarioEmprendedorLoading());
      try {
        await putUsuarioEmprendedorUsecase(event.id, event.usuario, event.imagen);
        final usuario = await getUsuarioByIdEmprendedorUsecase(event.id); // Recargar lista
        emit(UsuarioEmprendedorProfileLoaded(usuario));
      } catch (e) {
        emit(UsuarioEmprendedorError("Error al actualizar usuario: $e"));
      }
    });

    on<GetMyUsuarioEmprendedorEvent>((event, emit) async {
      print('[UsuarioBloc] Ejecutando GetMyUsuarioEvent');
      emit(UsuarioEmprendedorLoading());
      try {
        final token = await tokenStorageService.getToken();
        print('Token obtenido: $token');
        if (token == null) {
          emit(const UsuarioEmprendedorError("Token inválido: no se encontró el idUsuario"));
          return;
        }

        final id = getIdUsuarioFromToken(token);
        if (id == null) {
          emit(const UsuarioEmprendedorError("Token inválido: no se encontró el idUsuario"));
          return;
        }

        final usuario = await getUsuarioByIdEmprendedorUsecase(id);
        emit(UsuarioEmprendedorProfileLoaded(usuario)); // <- CAMBIO AQUÍ
      } catch (e) {
        emit(UsuarioEmprendedorError("Error al obtener datos del usuario actual: $e"));
      }
    });
  }
}