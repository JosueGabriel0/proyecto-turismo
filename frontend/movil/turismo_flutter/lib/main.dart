import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:turismo_flutter/app.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuario_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuarios_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_bloc.dart';
import 'package:turismo_flutter/injection/injection.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_bloc.dart'; // Importa el RolBloc

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(loginUseCase: getIt()), // Inyecta el LoginBloc
        ),
        BlocProvider<RolBloc>(
          create: (context) => RolBloc(
            getRolesUseCase: getIt(),
            getRolByIdUseCase: getIt(),
            createRolUseCase: getIt(),
            updateRolUseCase: getIt(),
            deleteRolUseCase: getIt(),
          )..add(GetRolesEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<UsuarioBloc>(
          create: (context) => UsuarioBloc(
            getAllUsuariosUseCase: getIt(),
            getUsuarioByIdUseCase: getIt(),
            createUsuarioUseCase: getIt(),
            updateUsuarioUseCase: getIt(),
            deleteUsuarioUseCase: getIt(),
            tokenStorageService: getIt(),
          )..add(GetAllUsuariosEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<LugarBloc>(
          create: (context) => LugarBloc(
            getLugaresUseCase: getIt(),
            getLugarByIdUseCase: getIt(),
            createLugarUsecase: getIt(),
            updateLugarUseCase: getIt(),
            deleteLugarUseCase: getIt(),
          )..add(GetAllLugaresEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<FileBloc>(
          create: (context) => getIt<FileBloc>(),
        ),
        // Otros proveedores si es necesario
      ],
      child: const App(),
    ),
  );
}