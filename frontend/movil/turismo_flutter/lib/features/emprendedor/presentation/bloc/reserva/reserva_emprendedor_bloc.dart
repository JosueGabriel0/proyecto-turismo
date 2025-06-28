import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/reserva/actualizar_reserva_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/reserva/crear_reserva_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/reserva/obtener_reserva_por_id_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/reserva/obtener_reservas_por_emprendimiento_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/reserva/reserva_emprendedor_event.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/reserva/reserva_emprendedor_state.dart';

class ReservaEmprendedorBloc extends Bloc<ReservaEmprendedorEvent, ReservaEmprendedorState> {
  final CrearReservaEmprendedorUsecase crearReservaEmprendedorUsecase;
  final ActualizarReservaEmprendedorUsecase actualizarReservaEmprendedorUsecase;
  final ObtenerReservasPorEmprendimientoUseCase obtenerReservasPorEmprendimientoUseCase;
  final ObtenerReservaPorIdUseCase obtenerReservaPorIdUseCase;

  ReservaEmprendedorBloc({
    required this.crearReservaEmprendedorUsecase,
    required this.actualizarReservaEmprendedorUsecase,
    required this.obtenerReservasPorEmprendimientoUseCase,
    required this.obtenerReservaPorIdUseCase,
  }) : super(ReservaInitial()) {
    on<CrearReservaEvent>((event, emit) async {
      emit(ReservaLoading());
      try {
        final reserva = await crearReservaEmprendedorUsecase(event.reserva);
        emit(ReservaCreada(reserva));
      } catch (e) {
        emit(ReservaError('Error al crear la reserva: $e'));
      }
    });

    on<ActualizarEstadoReservaEvent>((event, emit) async {
      emit(ReservaLoading());
      try {
        final reserva = await actualizarReservaEmprendedorUsecase(event.idReserva, event.nuevoEstado);
        emit(ReservaActualizada(reserva));
      } catch (e) {
        emit(ReservaError('Error al actualizar el estado: $e'));
      }
    });

    on<ObtenerReservasPorEmprendimientoEvent>((event, emit) async {
      emit(ReservaLoading());
      try {
        final reservas = await obtenerReservasPorEmprendimientoUseCase(event.idEmprendimiento);
        emit(ReservasCargadas(reservas));
      } catch (e) {
        emit(ReservaError('Error al obtener reservas: $e'));
      }
    });

    on<ObtenerReservaPorIdEvent>((event, emit) async {
      emit(ReservaLoading());
      try {
        final reserva = await obtenerReservaPorIdUseCase(event.idReserva);
        emit(ReservaCargada(reserva));
      } catch (e) {
        emit(ReservaError('Error al obtener reserva: $e'));
      }
    });
  }
}