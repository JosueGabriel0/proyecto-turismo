import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/general/domain/usecases/ubicacion/obtener_ubicaciones_usecase.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/ubicacion/ubicacion_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/ubicacion/ubicacion_state.dart';

class UbicacionBloc extends Bloc<UbicacionEvent, UbicacionState> {
  final ObtenerUbicacionesUseCase obtenerUbicaciones;

  UbicacionBloc({required this.obtenerUbicaciones}) : super(UbicacionInitial()) {
    on<ObtenerUbicacionesEvent>(_onObtenerUbicaciones);
  }

  Future<void> _onObtenerUbicaciones(
      ObtenerUbicacionesEvent event,
      Emitter<UbicacionState> emit,
      ) async {
    emit(UbicacionLoading());

    try {
      final ubicaciones = await obtenerUbicaciones();
      emit(UbicacionLoaded(ubicaciones));
    } catch (e) {
      emit(UbicacionError("Error al cargar ubicaciones: ${e.toString()}"));
    }
  }
}