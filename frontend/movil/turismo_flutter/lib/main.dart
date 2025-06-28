import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:turismo_flutter/app.dart';
import 'package:turismo_flutter/config/theme/local_theme_provider.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuario_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuarios_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/dashboard/dashboard_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/dashboard/dashboard_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia_categoria/familia_categoria_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia_categoria/familia_categoria_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/mensaje/mensaje_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/perfil/perfil_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/servicio_turistico/servicio_turistico_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/servicio_turistico/servicio_turistico_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_bloc.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:turismo_flutter/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/reserva/reserva_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/servicio_turistico/servicio_turistico_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/usuario/usuario_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia/familia_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia/familia_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia_categoria/familia_categoria_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia_categoria/familia_categoria_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/servicio_turistico/servicio_turistico_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/servicio_turistico/servicio_turistico_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/ubicacion/ubicacion_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';
import 'package:turismo_flutter/injection/injection.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_bloc.dart'; // Importa el RolBloc

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();      // ✅ Espera que todas las dependencias estén listas
  await setup();              // Tu otra función async
  await initializeDateFormatting('es', '');

  // 👉 Obtener usuario actual desde token
  final tokenService = TokenStorageService();
  final token = await tokenService.getToken();
  final usuarioActual = getUsernameFromToken(token ?? '') ?? 'anonimo';

  final chatBloc = getIt<ChatBloc>(param1: usuarioActual);
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(loginUseCase: getIt()), // Inyecta el LoginBloc
        ),
        BlocProvider(
          create: (context) => RegisterBloc(registerUseCase: getIt()),
        ),
        BlocProvider<DashboardAdminBloc>(
          create: (context) => DashboardAdminBloc(
              getDashboardUseCase: getIt(),
          )..add(LoadDashboardAdminEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<UsuarioUserBloc>(
          create: (context) => UsuarioUserBloc(
            getUsuarioByIdUserUseCase: getIt(),
            putUsuarioUserUseCase:  getIt(),
            buscarIdPorUsernameUserUsecase: getIt(),
            tokenStorageService: getIt()
          ), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<RolBloc>(
          create: (context) => RolBloc(
            getRolesUseCase: getIt(),
            getRolByIdUseCase: getIt(),
            createRolUseCase: getIt(),
            updateRolUseCase: getIt(),
            deleteRolUseCase: getIt(),
           buscarRolesPorNombreUsecase: getIt()
          )..add(GetRolesEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<UsuarioBloc>(
          create: (context) => UsuarioBloc(
            getAllUsuariosUseCase: getIt(),
            getUsuarioByIdUseCase: getIt(),
            createUsuarioUseCase: getIt(),
            updateUsuarioUseCase: getIt(),
            deleteUsuarioUseCase: getIt(),
            buscarUsuariosCompletosPorNombreUsecase: getIt(),
            buscarIdPorUsernameUsecase: getIt(),
            tokenStorageService: getIt(),
          )..add(GetAllUsuariosEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<PerfilAdminBloc>(
          create: (context) => PerfilAdminBloc(
            getUsuarioByIdUseCase: getIt(),
            updateUsuarioUseCase: getIt(),
            tokenStorageService: getIt(),
          ), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<LugarBloc>(
          create: (context) => LugarBloc(
            getLugaresUseCase: getIt(),
            getLugarByIdUseCase: getIt(),
            createLugarUsecase: getIt(),
            updateLugarUseCase: getIt(),
            deleteLugarUseCase: getIt(),
            buscarLugaresPorNombreUsecase: getIt(),
          )..add(GetAllLugaresEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<LugarGeneralBloc>(
          create: (context) => LugarGeneralBloc(
            getLugaresGeneralUseCase: getIt(),
            buscarLugaresPorNombreGeneralUsecase: getIt(),
            getFamiliasPorLugarGeneralUsecase: getIt()
          )..add(GetAllLugaresGeneralEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<FamiliaBloc>(
          create: (context) => FamiliaBloc(
            getFamiliasUsecase: getIt(),
            getFamiliaByIdUsecase: getIt(),
            postFamiliaUsecase: getIt(),
            putFamiliaUseCase: getIt(),
            deleteFamiliaUsecase: getIt(),
            buscarFamiliasPorNombreUsecase: getIt(),
          )..add(GetFamiliasEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<FamiliaGeneralBloc>(
          create: (context) => FamiliaGeneralBloc(
            buscarFamiliasPorNombreUsecaseGeneral: getIt(),
            getFamiliaByIdUsecaseGeneral: getIt(),
            getFamiliasUsecaseGeneral: getIt()
          )..add(GetFamiliasEventGeneral()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<CategoriaBloc>(
          create: (context) => CategoriaBloc(
            getCategoriasUsecase: getIt(),
            getCategoriaByIdUsecase: getIt(),
            postCategoriaUsecase: getIt(),
            putCategoriaUsecase: getIt(),
            deleteCategoriaUseCase: getIt(),
            buscarCategoriasPorNombreUsecase: getIt(),
          )..add(GetCategoriasEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<CategoriaGeneralBloc>(
          create: (context) => CategoriaGeneralBloc(
            getCategoriaByIdUsecaseGeneral: getIt(),
            buscarCategoriasPorNombreUsecaseGeneral: getIt(),
            getCategoriasUsecaseGeneral: getIt()
          )..add(GetCategoriasGeneralEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<FamiliaCategoriaBloc>(
          create: (context) => FamiliaCategoriaBloc(
            asociarFamiliaCategoriaUseCase: getIt(),
            eliminarRelacionUsecase: getIt(),
            listarRelacionesUsecase: getIt(),
            obtenerPorIdCategoriaUsecase: getIt(),
            obtenerPorIdFamiliaUsecase: getIt(),
          )..add(ListarRelacionesEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<FamiliaCategoriaGeneralBloc>(
          create: (context) => FamiliaCategoriaGeneralBloc(
            listarRelacionesUsecaseGeneral: getIt(),
            obtenerPorIdCategoriaUsecaseGeneral: getIt(),
            obtenerPorIdFamiliaUsecaseGeneral: getIt(),
            getEmprendimientosPorFamiliaCategoriaUsecaseGeneral: getIt(),
          ), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<EmprendimientoBloc>(
          create: (context) => EmprendimientoBloc(
            getEmprendimientosUsecase: getIt(),
            getEmprendimientoByIdUsecase: getIt(),
            postEmprendimientoUsecase: getIt(),
            putEmprendimientoUsecase: getIt(),
            deleteEmprendimientoUseCase: getIt(),
            buscarEmprendimientosPorNombreUseCase: getIt(),
          )..add(GetEmprendimientosEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<EmprendimientoGeneralBloc>(
          create: (context) => EmprendimientoGeneralBloc(
            buscarEmprendimientosPorNombreUseCaseGeneral: getIt(),
            getEmprendimientoByIdUsecaseGeneral: getIt(),
            getEmprendimientosUsecaseGeneral: getIt()
          )..add(GetEmprendimientosGeneralEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<EmprendimientoEmprendedorBloc>(
          create: (context) => EmprendimientoEmprendedorBloc(
            getUseCase: getIt(),
            updateUseCase: getIt()
          ), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<ServicioTuristicoBloc>(
          create: (context) => ServicioTuristicoBloc(
              buscarServiciosTuristicosPorNombreUsecase: getIt(),
              deleteServicioTuristicoUsecase: getIt(),
              updateServicioTuristicoUseCase: getIt(),
            createServicioTuristicoUsecase: getIt(),
            getServiciosTuristicosUsecase: getIt(),
            getServicioTuristicoByIdUsecase: getIt(),
          )..add(GetAllServiciosTuristicosEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<ServicioTuristicoEmprendedorBloc>(
          create: (context) => ServicioTuristicoEmprendedorBloc(
            obtenerPorId: getIt(),
            obtenerPorEmprendimiento: getIt(),
            eliminar: getIt(),
            crear: getIt(),
            buscarPorNombre: getIt(),
            actualizar: getIt(),
          ),
        ),
        BlocProvider<ReservaBloc>(
          create: (context) => ReservaBloc(
            obtenerTelefonoUseCase: getIt(),
            crearReservaUseCase: getIt(),
            obtenerReservasPorIdUsuariUsecase: getIt(),
            obtenerReservaPorIdUsecase: getIt(),
          ), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<ServicioTuristicoGeneralBloc>(
          create: (context) => ServicioTuristicoGeneralBloc(
              getServiciosUseCase: getIt(),
          ) // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<UsuarioEmprendedorBloc>(
            create: (context) => UsuarioEmprendedorBloc(
              getUsuarioByIdEmprendedorUsecase: getIt(),
              putUsuarioEmprendedorUsecase: getIt(),
              buscarIdPorUsernameEmprendedorUsecase: getIt(),
              tokenStorageService: getIt()
            ) // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<ReservaEmprendedorBloc>(
            create: (context) => ReservaEmprendedorBloc(
                actualizarReservaEmprendedorUsecase: getIt(),
                crearReservaEmprendedorUsecase: getIt(),
                obtenerReservaPorIdUseCase: getIt(),
                obtenerReservasPorEmprendimientoUseCase: getIt()
            ) // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<ChatBloc>(
          create: (_) => getIt<ChatBloc>(param1: usuarioActual),
        ),
        BlocProvider<MensajeAdminBloc>(
            create: (context) => MensajeAdminBloc(
                obtenerHistorial: getIt(),
                obtenerChatsRecientes: getIt(),
            ) // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<FileAdminBloc>(
            create: (context) => FileAdminBloc(
              uploadUsecase: getIt(),
              downloadUsecase: getIt(),
            ) // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<UbicacionBloc>(
            create: (context) => UbicacionBloc(
                obtenerUbicaciones: getIt(),
            )
        ),
        BlocProvider<FileBloc>(
          create: (context) => getIt<FileBloc>(),
        ),
        // Otros proveedores si es necesario
      ],
      child: ChangeNotifierProvider(
        create: (_) => LocalThemeProvider(),
        child: const App(),
      ),
    ),
  );
}

Future<void> setup() async {
  await dotenv.load(
    fileName: ".env",
  );
  MapboxOptions.setAccessToken(
    dotenv.env["MAPBOX_ACCESS_TOKEN"]!,
  );
}