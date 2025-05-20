  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/buscar_familias_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/buscar_lugares_por_nombre_usecase.dart';
  import 'package:turismo_flutter/features/admin/domain/usecases/lugar/create_lugar_usecase.dart';
  import 'package:turismo_flutter/features/admin/domain/usecases/lugar/delete_lugar_usecase.dart';
  import 'package:turismo_flutter/features/admin/domain/usecases/lugar/get_lugar_by_id_usecase.dart';
  import 'package:turismo_flutter/features/admin/domain/usecases/lugar/get_lugares_usecase.dart';
  import 'package:turismo_flutter/features/admin/domain/usecases/lugar/update_lugar_usecase.dart';
  import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_event.dart';
  import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_state.dart';

  class LugarBloc extends Bloc<LugarEvent, LugarState>{
    final GetLugaresUseCase getLugaresUseCase;
    final GetLugarByIdUseCase getLugarByIdUseCase;
    final CreateLugarUsecase createLugarUsecase;
    final UpdateLugarUseCase updateLugarUseCase;
    final DeleteLugarUseCase deleteLugarUseCase;
    final BuscarLugaresPorNombreUsecase buscarLugaresPorNombreUsecase;

    LugarBloc({
      required this.getLugaresUseCase,
      required this.getLugarByIdUseCase,
      required this.createLugarUsecase,
      required this.updateLugarUseCase,
      required this.deleteLugarUseCase,
      required this.buscarLugaresPorNombreUsecase,
    }) : super(LugarInitial()){
      on<GetAllLugaresEvent>((event, emit) async {
        print("Ejecutando GetAllLugaresEvent");
        emit(LugarLoading());
        try{
          final lugares = await getLugaresUseCase();
          emit(LugarListLoaded(lugares));
        }catch (e) {
          emit(LugarError("Error al obtener lugares: $e"));
        }
      });

      on<GetLugarByIdEvent>((event, emit) async {
        emit(LugarLoading());
        try{
          final lugar = await getLugarByIdUseCase(event.id);
          emit(LugarLoaded(lugar));
        }catch (e) {
          emit(LugarError("Error al obtener lugar: $e"));
        }
      });

      on<PostLugarEvent>((event, emit) async {
        emit(LugarLoading());
        try{
          await createLugarUsecase(event.lugarDto, event.imagen);
          emit(const LugarSuccess("Lugar creado con éxito"));
          final lugares = await getLugaresUseCase();
          emit(LugarListLoaded(lugares));
        }catch (e) {
          emit(LugarError("Error al crear lugar: $e"));
        }
      });

      on<PutLugarEvent>((event, emit) async {
        emit(LugarLoading());
        try {
          await updateLugarUseCase(event.id, event.lugarDto, event.imagen);
          emit(const LugarSuccess("Lugar actualizado con éxito"));
          final lugares = await getLugaresUseCase();
          emit(LugarListLoaded(lugares));
        }catch (e) {
          emit(LugarError("Error al actualizar el lugar: $e"));
        }
      });

      on<DeleteLugarEvent>((event, emit) async {
        emit(LugarLoading());
        try {
          await deleteLugarUseCase(event.id);
          emit(const LugarSuccess("Lugar eliminado con éxito"));
          final lugares = await getLugaresUseCase();
          emit(LugarListLoaded(lugares));
        }catch (e) {
          emit(LugarError("Error al eliminar lugar: $e"));
        }
      });

      on<BuscarLugaresPorNombreEvent>(
            (event, emit) async {
          try {
            final resultados = await buscarLugaresPorNombreUsecase(event.nombre);
            emit(LugarListLoaded(resultados));
          } catch (e) {
            emit(LugarError("Error al buscar lugares: $e"));
          }
        },
        transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
      );
    }
  }