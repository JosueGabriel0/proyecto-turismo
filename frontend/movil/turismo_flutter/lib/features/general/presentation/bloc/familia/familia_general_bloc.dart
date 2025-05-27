import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/buscar_familias_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/delete_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/get_familia_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/get_familias_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/post_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/put_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_state.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia/buscar_familias_por_nombre_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia/get_familia_by_id_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia/get_familias_usecase_general.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia/familia_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia/familia_general_state.dart';

class FamiliaGeneralBloc extends Bloc<FamiliaGeneralEvent, FamiliaGeneralState>{
  final GetFamiliasUsecaseGeneral getFamiliasUsecaseGeneral;
  final GetFamiliaByIdUsecaseGeneral getFamiliaByIdUsecaseGeneral;
  final BuscarFamiliasPorNombreUsecaseGeneral buscarFamiliasPorNombreUsecaseGeneral;

  FamiliaGeneralBloc({
    required this.getFamiliasUsecaseGeneral,
    required this.getFamiliaByIdUsecaseGeneral,
    required this.buscarFamiliasPorNombreUsecaseGeneral,
}): super(FamiliaInitialGeneral()){
    on<GetFamiliasEventGeneral>((event, emit) async {
      emit(FamiliaLoadingGeneral());
      try{
        final familiaListResponse = await getFamiliasUsecaseGeneral();
        emit(FamiliaListLoadedGeneral(familiaListResponse));
      } catch (e) {
        emit(FamiliaErrorGeneral("Error al obtener familias: $e"));
      }
    });

    on<GetFamiliaByIdEventGeneral>((event, emit) async {
      emit(FamiliaLoadingGeneral());
      try{
        final familiaResponse = await getFamiliaByIdUsecaseGeneral(event.idFamilia);
        emit(FamiliaLoadedGeneral(familiaResponse));
      }catch (e) {
        emit(FamiliaErrorGeneral("Error al obtener familia: $e"));
      }
    });

    on<BuscarFamiliasPorNombreEventGeneral>(
          (event, emit) async {
        try {
          final resultados = await buscarFamiliasPorNombreUsecaseGeneral(event.nombre);
          emit(FamiliaListLoadedGeneral(resultados));
        } catch (e) {
          emit(FamiliaErrorGeneral("Error al buscar familia: $e"));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }
}