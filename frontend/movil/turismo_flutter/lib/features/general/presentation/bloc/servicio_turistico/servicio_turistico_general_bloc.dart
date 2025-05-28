import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/general/domain/usecases/servicio_turistico/get_servicios_por_emprendimiento_usecase.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/servicio_turistico/servicio_turistico_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/servicio_turistico/servicio_turistico_general_state.dart';

class ServicioTuristicoGeneralBloc extends Bloc<ServicioTuristicoGeneralEvent, ServicioTuristicoGeneralState> {
  final GetServiciosPorEmprendimientoUseCase getServiciosUseCase;

  ServicioTuristicoGeneralBloc({ required this.getServiciosUseCase}) : super(ServicioTuristicoGeneralInitial()) {
    on<GetServiciosPorEmprendimientoEvent>((event, emit) async {
      emit(ServicioTuristicoGeneralLoading());

      try {
        final servicios = await getServiciosUseCase(event.idEmprendimiento);
        emit(ServicioTuristicoGeneralLoaded(servicios));
      } catch (e) {
        emit(ServicioTuristicoGeneralError('Error al cargar servicios: ${e.toString()}'));
      }
    });
  }
}
