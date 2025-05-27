import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/buscar_emprendimientos_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/delete_emprendimiento_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/get_emprendimiento_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/get_emprendimientos_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/post_emprendimiento_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/put_emprendimiento_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/features/general/domain/usecases/emprendimiento/buscar_emprendimientos_por_nombre_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/emprendimiento/get_emprendimiento_by_id_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/emprendimiento/get_emprendimientos_usecase_general.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_state.dart';

class EmprendimientoGeneralBloc extends Bloc<EmprendimientoGeneralEvent, EmprendimientoGeneralState> {
  final GetEmprendimientosUsecaseGeneral getEmprendimientosUsecaseGeneral;
  final GetEmprendimientoByIdUsecaseGeneral getEmprendimientoByIdUsecaseGeneral;
  final BuscarEmprendimientosPorNombreUseCaseGeneral buscarEmprendimientosPorNombreUseCaseGeneral;

  EmprendimientoGeneralBloc({
    required this.getEmprendimientosUsecaseGeneral,
    required this.getEmprendimientoByIdUsecaseGeneral,
    required this.buscarEmprendimientosPorNombreUseCaseGeneral,
  }) : super(EmprendimientoInitialGeneral()) {
    on<GetEmprendimientosGeneralEvent>((event, emit) async {
      emit(EmprendimientoLoadingGeneral());
      try {
        final emprendimientos = await getEmprendimientosUsecaseGeneral();
        emit(EmprendimientoListLoadedGeneral(emprendimientos));
      } catch (e) {
        emit(EmprendimientoErrorGeneral("Error al obtener emprendimientos: $e"));
      }
    });

    on<GetEmprendimientoByIdGeneralEvent>((event, emit) async {
      emit(EmprendimientoLoadingGeneral());
      try {
        print("Evento recibido en Bloc con id: ${event.idEmprendimiento}");
        final emprendimiento = await getEmprendimientoByIdUsecaseGeneral(event.idEmprendimiento);
        emit(EmprendimientoLoadedGeneral(emprendimiento));
        print("Emprendimiento cargado: ${emprendimiento.nombre} con id ${emprendimiento.idEmprendimiento}");
      } catch (e) {
        emit(EmprendimientoErrorGeneral("Error al obtener emprendimiento: $e"));
      }
    });

    on<BuscarEmprendimientosPorNombreGeneralEvent>(
          (event, emit) async {
        try {
          final resultados = await buscarEmprendimientosPorNombreUseCaseGeneral(event.nombre);
          emit(EmprendimientoListLoadedGeneral(resultados));
        } catch (e) {
          emit(EmprendimientoErrorGeneral("Error al buscar emprendimientos: $e"));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }
}