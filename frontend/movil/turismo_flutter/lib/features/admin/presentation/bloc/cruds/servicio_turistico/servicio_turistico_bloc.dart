  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/buscar_familias_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/buscar_lugares_por_nombre_usecase.dart';
  import 'package:turismo_flutter/features/admin/domain/usecases/lugar/create_lugar_usecase.dart';
  import 'package:turismo_flutter/features/admin/domain/usecases/lugar/delete_lugar_usecase.dart';
  import 'package:turismo_flutter/features/admin/domain/usecases/lugar/get_lugar_by_id_usecase.dart';
  import 'package:turismo_flutter/features/admin/domain/usecases/lugar/get_lugares_usecase.dart';
  import 'package:turismo_flutter/features/admin/domain/usecases/lugar/update_lugar_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/servicio_turistico/buscar_servicios_turisticos_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/servicio_turistico/create_servicio_turistico_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/servicio_turistico/delete_servicio_turistico_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/servicio_turistico/get_servicio_turistico_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/servicio_turistico/get_servicios_turisticos_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/servicio_turistico/upgrate_servicio_turistico_usecase.dart';
  import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_event.dart';
  import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/servicio_turistico/servicio_turistico_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/servicio_turistico/servicio_turistico_state.dart';

  class ServicioTuristicoBloc extends Bloc<ServicioTuristicoEvent, ServicioTuristicoState>{
    final GetServiciosTuristicosUsecase getServiciosTuristicosUsecase;
    final GetServicioTuristicoByIdUsecase getServicioTuristicoByIdUsecase;
    final CreateServicioTuristicoUsecase createServicioTuristicoUsecase;
    final UpdateServicioTuristicoUseCase updateServicioTuristicoUseCase;
    final DeleteServicioTuristicoUsecase deleteServicioTuristicoUsecase;
    final BuscarServiciosTuristicosPorNombreUsecase buscarServiciosTuristicosPorNombreUsecase;

    ServicioTuristicoBloc({
      required this.getServiciosTuristicosUsecase,
      required this.getServicioTuristicoByIdUsecase,
      required this.createServicioTuristicoUsecase,
      required this.updateServicioTuristicoUseCase,
      required this.deleteServicioTuristicoUsecase,
      required this.buscarServiciosTuristicosPorNombreUsecase,
    }) : super(ServicioTuristicoInitial()){
      on<GetAllServiciosTuristicosEvent>((event, emit) async {
        print("Ejecutando GetAllServiciosTuristicosEvent");
        emit(ServicioTuristicoLoading());
        try{
          final serviciosTuristicos = await getServiciosTuristicosUsecase();
          emit(ServicioTuristicoListLoaded(serviciosTuristicos));
        }catch (e) {
          emit(ServicioTuristicoError("Error al obtener servicios turisticos: $e"));
        }
      });

      on<GetServicioTuristicoByIdEvent>((event, emit) async {
        emit(ServicioTuristicoLoading());
        try{
          final servicioTuristico = await getServicioTuristicoByIdUsecase(event.id);
          emit(ServicioTuristicoLoaded(servicioTuristico));
        }catch (e) {
          emit(ServicioTuristicoError("Error al obtener servicio turistico: $e"));
        }
      });

      on<PostServicioTuristicoEvent>((event, emit) async {
        emit(ServicioTuristicoLoading());
        try{
          await createServicioTuristicoUsecase(event.servicioTuristicoDto, event.imagen);
          emit(const ServicioTuristicoSuccess("Servicio creado con éxito"));
          final serviciosTuristicos = await getServiciosTuristicosUsecase();
          emit(ServicioTuristicoListLoaded(serviciosTuristicos));
        }catch (e) {
          emit(ServicioTuristicoError("Error al crear servicio turistico: $e"));
        }
      });

      on<PutServicioTuristicoEvent>((event, emit) async {
        emit(ServicioTuristicoLoading());
        try {
          await updateServicioTuristicoUseCase(event.id, event.servicioTuristicoDto, event.imagen);
          emit(const ServicioTuristicoSuccess("Servicio turistico actualizado con éxito"));
          final serviciosTuristicos = await getServiciosTuristicosUsecase();
          emit(ServicioTuristicoListLoaded(serviciosTuristicos));
        }catch (e) {
          emit(ServicioTuristicoError("Error al actualizar el servicio turistico: $e"));
        }
      });

      on<DeleteServicioTuristicoEvent>((event, emit) async {
        emit(ServicioTuristicoLoading());
        try {
          await deleteServicioTuristicoUsecase(event.id);
          emit(const ServicioTuristicoSuccess("Servicio turistico eliminado con éxito"));
          final serviciosTuristicos = await getServiciosTuristicosUsecase();
          emit(ServicioTuristicoListLoaded(serviciosTuristicos));
        }catch (e) {
          emit(ServicioTuristicoError("Error al eliminar servicio turistico: $e"));
        }
      });

      on<BuscarServiciosTuristicosPorNombreEvent>(
            (event, emit) async {
          try {
            final resultados = await buscarServiciosTuristicosPorNombreUsecase(event.nombre);
            emit(ServicioTuristicoListLoaded(resultados));
          } catch (e) {
            emit(ServicioTuristicoError("Error al buscar servicio turistico: $e"));
          }
        },
        transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
      );
    }
  }