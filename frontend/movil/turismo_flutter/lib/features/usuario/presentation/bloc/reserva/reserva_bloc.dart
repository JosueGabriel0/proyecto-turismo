import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/reserva/crear_reserva_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/reserva/obtener_telefono_usecase.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_state.dart';

class ReservaBloc extends Bloc<ReservaEvent, ReservaState> {
  final CrearReservaUseCase crearReservaUseCase;
  final ObtenerTelefonoUseCase obtenerTelefonoUseCase;

  ReservaBloc({
    required this.crearReservaUseCase,
    required this.obtenerTelefonoUseCase,
  }) : super(ReservaInitial()) {
    on<CrearReservaEvent>(_onCrearReserva);
    on<ObtenerTelefonoEvent>(_onObtenerTelefono);
  }

  Future<void> _onCrearReserva(
      CrearReservaEvent event, Emitter<ReservaState> emit) async {
    emit(ReservaLoading());
    try {
      final reserva = await crearReservaUseCase.call(event.reserva);
      emit(ReservaCreada(reserva));
    } catch (e) {
      emit(ReservaError("Error al crear la reserva: ${e.toString()}"));
    }
  }

  Future<void> _onObtenerTelefono(
      ObtenerTelefonoEvent event, Emitter<ReservaState> emit) async {
    emit(ReservaLoading());
    try {
      final telefono = await obtenerTelefonoUseCase.call(event.idEmprendimiento);
      emit(TelefonoObtenido(telefono));
    } catch (e) {
      emit(ReservaError("Error al obtener el teléfono: ${e.toString()}"));
    }
  }
}