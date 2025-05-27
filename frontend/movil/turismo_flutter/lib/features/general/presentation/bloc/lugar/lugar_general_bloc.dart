import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/features/general/domain/usecases/lugar/buscar_lugares_por_nombre_general_usecase.dart';
import 'package:turismo_flutter/features/general/domain/usecases/lugar/get_familias_por_lugar_general_usecase.dart';
import 'package:turismo_flutter/features/general/domain/usecases/lugar/get_lugares_general_usecase.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_state.dart';

class LugarGeneralBloc extends Bloc<LugarGeneralEvent, LugarGeneralState> {
  final GetLugaresGeneralUsecase getLugaresGeneralUseCase;
  final BuscarLugaresPorNombreGeneralUsecase buscarLugaresPorNombreGeneralUsecase;
  final GetFamiliasPorLugarGeneralUsecase getFamiliasPorLugarGeneralUsecase; // NUEVO

  LugarGeneralBloc({
    required this.getLugaresGeneralUseCase,
    required this.buscarLugaresPorNombreGeneralUsecase,
    required this.getFamiliasPorLugarGeneralUsecase, // NUEVO
  }) : super(LugarInitialGeneral()) {
    on<GetAllLugaresGeneralEvent>((event, emit) async {
      emit(LugarLoadingGeneral());
      try {
        final lugares = await getLugaresGeneralUseCase();
        emit(LugarListLoadedGeneral(lugares));
      } catch (e) {
        emit(LugarErrorGeneral("Error al obtener lugares: $e"));
      }
    });

    on<BuscarLugaresPorNombreGeneralEvent>(
          (event, emit) async {
        try {
          final resultados = await buscarLugaresPorNombreGeneralUsecase(event.nombre);
          emit(LugarListLoadedGeneral(resultados));
        } catch (e) {
          emit(LugarErrorGeneral("Error al buscar lugares: $e"));
        }
      },
      transformer: (events, mapper) =>
          events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );

    on<GetFamiliasPorLugarEvent>(
          (event, emit) async {
        emit(LugarLoadingGeneral());
        try {
          final familias = await getFamiliasPorLugarGeneralUsecase(event.idLugar, event.nombre);
          emit(FamiliasPorLugarLoadedGeneral(familias));
        } catch (e) {
          emit(LugarErrorGeneral("Error al buscar familias: $e"));
        }
      },
      transformer: (events, mapper) =>
          events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }
}
