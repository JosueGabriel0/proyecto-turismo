import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/reserva/crear_reserva_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/reserva/obtener_reserva_por_id_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/reserva/obtener_reservas_por_id_usuari_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/reserva/obtener_telefono_usecase.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_state.dart';

class ReservaBloc extends Bloc<ReservaEvent, ReservaState> {
  final CrearReservaUseCase crearReservaUseCase;
  final ObtenerTelefonoUseCase obtenerTelefonoUseCase;
  final ObtenerReservasPorIdUsuariUsecase obtenerReservasPorIdUsuariUsecase;
  final ObtenerReservaPorIdUsecase obtenerReservaPorIdUsecase;

  ReservaBloc({
    required this.crearReservaUseCase,
    required this.obtenerTelefonoUseCase,
    required this.obtenerReservasPorIdUsuariUsecase,
    required this.obtenerReservaPorIdUsecase,
  }) : super(ReservaInitial()) {
    on<CrearReservaEvent>(_onCrearReserva);
    on<ObtenerTelefonoEvent>(_onObtenerTelefono);
    on<ObtenerReservasPorIdUsuarioEvent>(_onObtenerReservasPorIdUsuario);
    on<ObtenerReservaPorIdEvent>(_onObtenerReservaPorId);
  }

  Future<void> _onCrearReserva(
      CrearReservaEvent event, Emitter<ReservaState> emit) async {
    emit(ReservaLoading());
    try {
      final reserva = await crearReservaUseCase.call(event.reserva);
      emit(ReservaCreada(reserva));
    } catch (e, stackTrace) {
      // Muestra el error con el stacktrace completo para depurar mejor
      final errorMsg = "Error al crear la reserva: $e\nStackTrace:\n$stackTrace";
      emit(ReservaError(errorMsg));
      // También puedes imprimirlo en consola para mayor visibilidad
      print(errorMsg);
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

  Future<void> _onObtenerReservasPorIdUsuario(
      ObtenerReservasPorIdUsuarioEvent event, Emitter<ReservaState> emit) async {
    emit(ReservaLoading());
    try {
      final reservas = await obtenerReservasPorIdUsuariUsecase.call(event.id);
      emit(ReservaListLoaded(reservas));
    } catch (e) {
      emit(ReservaError("Error al obtener las reservas: ${e.toString()}"));
    }
  }

  Future<void> _onObtenerReservaPorId(
      ObtenerReservaPorIdEvent event, Emitter<ReservaState> emit) async {
    emit(ReservaLoading());
    try {
      final reserva = await obtenerReservaPorIdUsecase.call(event.idReserva);
      emit(ReservaLoaded(reserva));
    } catch (e) {
      emit(ReservaError("Error al obtener la reserva: ${e.toString()}"));
    }
  }
}