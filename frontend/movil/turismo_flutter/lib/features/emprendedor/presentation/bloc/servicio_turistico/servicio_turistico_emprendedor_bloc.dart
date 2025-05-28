import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/buscar_servicios_turisticos_por_nombre_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/delete_servicio_turistico_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/get_servicio_turistico_by_id_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/get_servicios_turisticos_por_id_emprendimiento_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/post_servicio_turistico_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/put_servicio_turistico_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/servicio_turistico/servicio_turistico_emprendedor_event.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/servicio_turistico/servicio_turistico_emprendedor_state.dart';

class ServicioTuristicoEmprendedorBloc extends Bloc<ServicioTuristicoEmprendedorEvent, ServicioTuristicoEmprendedorState> {
  final BuscarServiciosTuristicosPorNombreEmprendedorUsecase buscarPorNombre;
  final DeleteServicioTuristicoEmprendedorUsecase eliminar;
  final GetServicioTuristicoByIdEmprendedorUsecase obtenerPorId;
  final GetServiciosTuristicosPorIdEmprendimientoEmprendedorUsecase obtenerPorEmprendimiento;
  final PostServicioTuristicoEmprendedorUsecase crear;
  final PutServicioTuristicoEmprendedorUsecase actualizar;

  ServicioTuristicoEmprendedorBloc({
    required this.buscarPorNombre,
    required this.eliminar,
    required this.obtenerPorId,
    required this.obtenerPorEmprendimiento,
    required this.crear,
    required this.actualizar,
  }) : super(ServicioInitialEmprendedor()) {
    on<BuscarServiciosPorNombreEmprendedorEvent>((event, emit) async {
      emit(ServicioLoadingEmprendedor());
      try {
        final servicios = await buscarPorNombre(event.nombre);
        emit(ServicioListLoadedEmprendedor(servicios));
      } catch (e) {
        emit(ServicioErrorEmprendedor(e.toString()));
      }
    },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );

    on<EliminarServicioTuristicoEmprendedorEvent>((event, emit) async {
      emit(ServicioLoadingEmprendedor());
      try {
        await eliminar(event.idServicio);
        emit(ServicioSuccessEmprendedor());
      } catch (e) {
        emit(ServicioErrorEmprendedor(e.toString()));
      }
    });

    on<ObtenerServicioPorIdEmprendedorEvent>((event, emit) async {
      emit(ServicioLoadingEmprendedor());
      try {
        final servicio = await obtenerPorId(event.idServicio);
        emit(ServicioLoadedEmprendedor(servicio));
      } catch (e) {
        emit(ServicioErrorEmprendedor(e.toString()));
      }
    });

    on<ObtenerServiciosPorIdEmprendimientoEmprendedorEvent>((event, emit) async {
      emit(ServicioLoadingEmprendedor());
      try {
        final servicios = await obtenerPorEmprendimiento(event.idEmprendimiento);
        emit(ServicioListLoadedEmprendedor(servicios));
      } catch (e) {
        emit(ServicioErrorEmprendedor(e.toString()));
      }
    });

    on<CrearServicioTuristicoEmprendedorEvent>((event, emit) async {
      emit(ServicioLoadingEmprendedor());
      try {
        await crear(event.dto, event.file);
        emit(ServicioSuccessEmprendedor());
      } catch (e) {
        emit(ServicioErrorEmprendedor(e.toString()));
      }
    });

    on<ActualizarServicioTuristicoEmprendedorEvent>((event, emit) async {
      emit(ServicioLoadingEmprendedor());
      try {
        await actualizar(event.idServicio, event.dto, event.file);
        emit(ServicioSuccessEmprendedor());
      } catch (e) {
        emit(ServicioErrorEmprendedor(e.toString()));
      }
    });
  }
}
