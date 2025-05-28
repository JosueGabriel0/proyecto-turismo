import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/emprendimiento/get_emprendimiento_by_id_usuario_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/emprendimiento/update_emprendimiento_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_event.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_state.dart';

class EmprendimientoEmprendedorBloc
    extends Bloc<EmprendimientoEmprendedorEvent, EmprendimientoEmprendedorState> {
  final GetEmprendimientoByIdUsuarioEmprendedorUsecase getUseCase;
  final UpdateEmprendimientoEmprendedorUsecase updateUseCase;

  EmprendimientoEmprendedorBloc({
    required this.getUseCase,
    required this.updateUseCase,
  }) : super(EmprendimientoEmprendedorInitial()) {
    on<GetEmprendimientoByIdUsuarioEmprendedorEvent>(_onGetEmprendimiento);
    on<UpdateEmprendimientoEmprendedorEvent>(_onUpdateEmprendimiento);
  }

  Future<void> _onGetEmprendimiento(
      GetEmprendimientoByIdUsuarioEmprendedorEvent event,
      Emitter<EmprendimientoEmprendedorState> emit,
      ) async {
    emit(EmprendimientoEmprendedorLoading());
    try {
      final response = await getUseCase.call(event.idUsuario);
      emit(EmprendimientoEmprendedorLoaded(response));
    } catch (e) {
      emit(EmprendimientoEmprendedorError("Error al obtener el emprendimiento: $e"));
    }
  }

  Future<void> _onUpdateEmprendimiento(
      UpdateEmprendimientoEmprendedorEvent event,
      Emitter<EmprendimientoEmprendedorState> emit,
      ) async {
    emit(EmprendimientoEmprendedorUpdating());
    try {
      final response = await updateUseCase.call(
        idEmprendimiento: event.idEmprendimiento,
        dto: event.dto,
        imageFile: event.file,
      );
      emit(EmprendimientoEmprendedorUpdated(response));
    } catch (e) {
      emit(EmprendimientoEmprendedorError("Error al actualizar el emprendimiento: $e"));
    }
  }
}
