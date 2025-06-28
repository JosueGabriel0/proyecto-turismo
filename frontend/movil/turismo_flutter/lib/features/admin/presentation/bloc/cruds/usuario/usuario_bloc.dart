import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/buscar_id_por_username_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/buscar_usuarios_completos_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/create_usuario_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/delete_usuario_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuario_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuarios_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/update_usuario_usecase.dart';
import 'usuario_event.dart';
import 'usuario_state.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final GetAllUsuariosUseCase getAllUsuariosUseCase;
  final GetUsuarioByIdUseCase getUsuarioByIdUseCase;
  final CreateUsuarioUseCase createUsuarioUseCase;
  final UpdateUsuarioUseCase updateUsuarioUseCase;
  final DeleteUsuarioUseCase deleteUsuarioUseCase;
  final BuscarUsuariosCompletosPorNombreUsecase buscarUsuariosCompletosPorNombreUsecase;
  final BuscarIdPorUsernameUsecase buscarIdPorUsernameUsecase;
  final TokenStorageService tokenStorageService;

  UsuarioBloc({
    required this.getAllUsuariosUseCase,
    required this.getUsuarioByIdUseCase,
    required this.createUsuarioUseCase,
    required this.updateUsuarioUseCase,
    required this.deleteUsuarioUseCase,
    required this.buscarUsuariosCompletosPorNombreUsecase,
    required this.buscarIdPorUsernameUsecase,
    required this.tokenStorageService,
  }) : super(UsuarioInitial()) {
    on<GetAllUsuariosEvent>((event, emit) async {
      emit(UsuarioLoading());
      try {
        final usuarios = await getAllUsuariosUseCase();
        emit(UsuarioListLoaded(usuarios));
      } catch (e) {
        emit(UsuarioError("Error al obtener usuarios: $e"));
      }
    });

    on<GetUsuarioByIdEvent>((event, emit) async {
      emit(UsuarioLoading());
      try {
        final usuario = await getUsuarioByIdUseCase(event.id);
        emit(UsuarioProfileLoaded(usuario));
      } catch (e) {
        emit(UsuarioError("Error al obtener usuario: $e"));
      }
    });

    on<CreateUsuarioEvent>((event, emit) async {
      emit(UsuarioLoading());
      try {
        await createUsuarioUseCase(event.usuario, event.imagen);
        final usuarios = await getAllUsuariosUseCase();
        emit(UsuarioListLoaded(usuarios));
      } catch (e) {
        emit(UsuarioError("Error al crear usuario: $e"));
      }
    });

    on<UpdateUsuarioEvent>((event, emit) async {
      emit(UsuarioLoading());
      try {
        await updateUsuarioUseCase(event.id, event.usuario, event.imagen);
        final usuarios = await getAllUsuariosUseCase();
        emit(UsuarioListLoaded(usuarios));
      } catch (e) {
        emit(UsuarioError("Error al actualizar usuario: $e"));
      }
    });

    on<DeleteUsuarioEvent>((event, emit) async {
      emit(UsuarioLoading());
      try {
        await deleteUsuarioUseCase(event.id);
        final usuarios = await getAllUsuariosUseCase();
        emit(UsuarioListLoaded(usuarios));
      } catch (e) {
        emit(UsuarioError("Error al eliminar usuario: $e"));
      }
    });

    on<GetMyUsuarioEvent>((event, emit) async {
      print('[UsuarioBloc] Ejecutando GetMyUsuarioEvent');
      emit(UsuarioLoading());
      try {
        final token = await tokenStorageService.getToken();
        print('Token obtenido: $token');
        if (token == null) {
          emit(const UsuarioError("Token inválido: no se encontró el idUsuario"));
          return;
        }

        final id = getIdUsuarioFromToken(token);
        if (id == null) {
          emit(const UsuarioError("Token inválido: no se encontró el idUsuario"));
          return;
        }

        final usuario = await getUsuarioByIdUseCase(id);

        // ✅ Aquí se emite el estado correcto
        emit(UsuarioProfileLoaded(usuario));

      } catch (e) {
        emit(UsuarioError("Error al obtener datos del usuario actual: $e"));
      }
    });

    on<BuscarUsuarioPorNombreEvent>(
          (event, emit) async {
        try {
          final resultados = await buscarUsuariosCompletosPorNombreUsecase(event.username);
          emit(UsuarioListLoaded(resultados));
        } catch (e) {
          emit(UsuarioError("Error al buscar usuarios: $e"));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );

    on<BuscarIdPorUsernameEvent>((event, emit) async {
      emit(BuscarIdLoading());

      try {
        final result = await buscarIdPorUsernameUsecase.call(event.username);
        emit(BuscarIdSuccess(result));
      } catch (e) {
        emit(BuscarIdError("No se pudo obtener el ID del usuario"));
      }
    });
  }
}