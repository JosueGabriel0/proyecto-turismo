import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/dashboard/get_dashboard_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/dashboard/dashboard_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/dashboard/dashboard_admin_state.dart';

class DashboardAdminBloc extends Bloc<DashboardAdminEvent, DashboardAdminState> {
  final GetDashboardUseCase getDashboardUseCase;

  DashboardAdminBloc({required this.getDashboardUseCase}) : super(DashboardAdminInitial()) {
    on<LoadDashboardAdminEvent>(_onLoadDashboard);
  }

  Future<void> _onLoadDashboard(
      LoadDashboardAdminEvent event,
      Emitter<DashboardAdminState> emit,
      ) async {
    emit(DashboardAdminLoading());

    try {
      final dashboard = await getDashboardUseCase();
      emit(DashboardAdminLoaded(dashboard));
    } catch (e) {
      emit(DashboardAdminError('Error al cargar el dashboard: ${e.toString()}'));
    }
  }
}
