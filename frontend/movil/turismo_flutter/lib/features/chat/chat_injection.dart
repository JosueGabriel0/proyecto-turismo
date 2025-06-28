import 'package:get_it/get_it.dart';
import 'package:turismo_flutter/config/constants/constants.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/features/chat/data/datasources/remote/chat_websocket_datasource.dart';
import 'package:turismo_flutter/features/chat/domain/repositories/chat_repository.dart';
import 'package:turismo_flutter/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:turismo_flutter/features/chat/domain/usecases/conectar_chat.dart';
import 'package:turismo_flutter/features/chat/domain/usecases/desconectar_chat.dart';
import 'package:turismo_flutter/features/chat/domain/usecases/enviar_mensaje.dart';
import 'package:turismo_flutter/features/chat/domain/usecases/editar_mensaje.dart';
import 'package:turismo_flutter/features/chat/domain/usecases/marcar_como_entregado.dart';
import 'package:turismo_flutter/features/chat/domain/usecases/marcar_como_leido.dart';
import 'package:turismo_flutter/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:turismo_flutter/features/chat/presentation/bloc/chat_event.dart';
import 'package:turismo_flutter/features/chat/data/mappers/mensaje_mapper.dart';

final getIt = GetIt.instance;

Future<void> injectChatDependencies() async {
  const String url = ApiConstants.baseUrlDevWebSocket;

  final tokenStorageService = TokenStorageService();
  final String? token = await tokenStorageService.getToken();

  final ChatWebSocketDatasource datasource = ChatWebSocketDatasource(
    url: url,
    accessToken: token ?? '',
    onMensajeRecibido: (_) {}, // Inicialmente vacíos
    onEstadoMensaje: (_) {},
    onMensajeEditado: (_) {},
  );

  getIt.registerLazySingleton<ChatWebSocketDatasource>(() => datasource);
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(getIt()));

  getIt.registerLazySingleton(() => ConectarChat(getIt()));
  getIt.registerLazySingleton(() => DesconectarChat(getIt()));
  getIt.registerLazySingleton(() => EnviarMensaje(getIt()));
  getIt.registerLazySingleton(() => EditarMensaje(getIt()));
  getIt.registerLazySingleton(() => MarcarComoEntregado(getIt()));
  getIt.registerLazySingleton(() => MarcarComoLeido(getIt()));

  getIt.registerFactoryParam<ChatBloc, String, void>((usuarioActual, _) {
    return ChatBloc(
      usuarioActual: usuarioActual,
      conectarChat: getIt(),
      desconectarChat: getIt(),
      enviarMensaje: getIt(),
      editarMensaje: getIt(),
      marcarComoEntregado: getIt(),
      marcarComoLeido: getIt(),
      datasource: getIt(),
    );
  });
}