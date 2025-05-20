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

class EmprendimientoBloc extends Bloc<EmprendimientoEvent, EmprendimientoState> {
  final DeleteEmprendimientoUseCase deleteEmprendimientoUseCase;
  final GetEmprendimientoByIdUsecase getEmprendimientoByIdUsecase;
  final GetEmprendimientosUsecase getEmprendimientosUsecase;
  final PostEmprendimientoUsecase postEmprendimientoUsecase;
  final PutEmprendimientoUsecase putEmprendimientoUsecase;
  final BuscarEmprendimientosPorNombreUseCase buscarEmprendimientosPorNombreUseCase;

  EmprendimientoBloc({
    required this.deleteEmprendimientoUseCase,
    required this.getEmprendimientoByIdUsecase,
    required this.getEmprendimientosUsecase,
    required this.postEmprendimientoUsecase,
    required this.putEmprendimientoUsecase,
    required this.buscarEmprendimientosPorNombreUseCase,
  }) : super(EmprendimientoInitial()) {
    on<DeleteEmprendimientoEvent>((event, emit) async {
      emit(EmprendimientoLoading());
      try {
        await deleteEmprendimientoUseCase(event.idEmprendimiento);
        emit(const EmprendimientoSuccess("Emprendimiento eliminado exitosamente"));
        final emprendimientos = await getEmprendimientosUsecase();
        emit(EmprendimientoListLoaded(emprendimientos));
      } catch (e) {
        emit(EmprendimientoError("Error al eliminar emprendimiento: $e"));
      }
    });

    on<GetEmprendimientoByIdEvent>((event, emit) async {
      emit(EmprendimientoLoading());
      try {
        final emprendimiento = await getEmprendimientoByIdUsecase(event.idEmprendimiento);
        emit(EmprendimientoLoaded(emprendimiento));
      } catch (e) {
        emit(EmprendimientoError("Error al obtener emprendimiento: $e"));
      }
    });

    on<GetEmprendimientosEvent>((event, emit) async {
      emit(EmprendimientoLoading());
      try {
        final emprendimientos = await getEmprendimientosUsecase();
        emit(EmprendimientoListLoaded(emprendimientos));
      } catch (e) {
        emit(EmprendimientoError("Error al obtener emprendimientos: $e"));
      }
    });

    on<PostEmprendimientoEvent>((event, emit) async {
      emit(EmprendimientoLoading());
      try {
        await postEmprendimientoUsecase(event.emprendimientoDto, event.file);
        emit(const EmprendimientoSuccess("Emprendimiento creado con éxito"));
        final emprendimientos = await getEmprendimientosUsecase();
        emit(EmprendimientoListLoaded(emprendimientos));
      } catch (e) {
        emit(EmprendimientoError("Error al crear emprendimiento: $e"));
      }
    });

    on<PutEmprendimientoEvent>((event, emit) async {
      emit(EmprendimientoLoading());
      try {
        await putEmprendimientoUsecase(event.idEmprendimiento, event.emprendimientoDto, event.file);
        emit(const EmprendimientoSuccess("Emprendimiento actualizado con éxito"));
        final emprendimientos = await getEmprendimientosUsecase();
        emit(EmprendimientoListLoaded(emprendimientos));
      } catch (e) {
        emit(EmprendimientoError("Error al actualizar emprendimiento: $e"));
      }
    });

    on<BuscarEmprendimientosPorNombreEvent>(
          (event, emit) async {
        try {
          final resultados = await buscarEmprendimientosPorNombreUseCase(event.nombre);
          emit(EmprendimientoListLoaded(resultados));
        } catch (e) {
          emit(EmprendimientoError("Error al buscar emprendimientos: $e"));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }
}