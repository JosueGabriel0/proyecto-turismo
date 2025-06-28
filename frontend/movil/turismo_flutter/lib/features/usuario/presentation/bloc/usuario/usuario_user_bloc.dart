import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/usuario/buscar_id_por_username_user_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/usuario/get_usuario_by_id_user_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/usuario/put_usuario_user_usecase.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_state.dart';

class UsuarioUserBloc extends Bloc<UsuarioUserEvent, UsuarioUserState> {
  final GetUsuarioByIdUserUseCase getUsuarioByIdUserUseCase;
  final PutUsuarioUserUseCase putUsuarioUserUseCase;
  final BuscarIdPorUsernameUserUsecase buscarIdPorUsernameUserUsecase;
  final TokenStorageService tokenStorageService;

  UsuarioUserBloc({
    required this.getUsuarioByIdUserUseCase,
    required this.putUsuarioUserUseCase,
    required this.buscarIdPorUsernameUserUsecase,
    required this.tokenStorageService,
  }) : super(UsuarioUserInitial()) {

    on<GetUsuarioByIdUserEvent>((event, emit) async {
      emit(UsuarioUserLoading());
      try {
        final usuario = await getUsuarioByIdUserUseCase(event.id);
        emit(UsuarioUserProfileLoaded(usuario));
      } catch (e) {
        emit(UsuarioUserError("Error al obtener usuario: $e"));
      }
    });

    on<PutUsuarioUserEvent>((event, emit) async {
      print("Evento llamado");
      emit(UsuarioUserLoading());
      try {
        final token = await tokenStorageService.getToken();
        final id = getIdUsuarioFromToken(token!);
        if (id == null) throw Exception("ID de usuario inválido");

        await putUsuarioUserUseCase(id, event.usuario, event.imagen);
        final usuario = await getUsuarioByIdUserUseCase(id); // Recargar lista
        emit(UsuarioUserProfileLoaded(usuario));
      } catch (e) {
        emit(UsuarioUserError("Error al actualizar usuario: $e"));
      }
    });

    on<GetMyUsuarioUserEvent>((event, emit) async {
      print('[UsuarioBloc] Ejecutando GetMyUsuarioEvent');
      emit(UsuarioUserLoading());
      try {
        final token = await tokenStorageService.getToken();
        print('Token obtenido: $token');
        if (token == null) {
          emit(const UsuarioUserError("Token inválido: no se encontró el idUsuario"));
          return;
        }

        final id = getIdUsuarioFromToken(token);
        if (id == null) {
          emit(const UsuarioUserError("Token inválido: no se encontró el idUsuario"));
          return;
        }

        final usuario = await getUsuarioByIdUserUseCase(id);
        emit(UsuarioUserProfileLoaded(usuario)); // <- CAMBIO AQUÍ
      } catch (e) {
        emit(UsuarioUserError("Error al obtener datos del usuario actual: $e"));
      }
    });

    on<BuscarIdPorUsernameUserEvent>((event, emit) async {
      emit(BuscarIdLoadingUser());

      try {
        final result = await buscarIdPorUsernameUserUsecase.call(event.username);
        emit(BuscarIdSuccessUser(result));
      } catch (e) {
        emit(BuscarIdErrorUser("No se pudo obtener el ID del usuario"));
      }
    });
  }
}