import 'package:turismo_flutter/features/admin/data/models/dashboard_admin_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/dashboard_admin_repository.dart';

class GetDashboardUseCase {
  final DashboardAdminRepository repository;

  GetDashboardUseCase(this.repository);

  Future<DashboardAdminResponse> call() {
    return repository.fetchDashboard();
  }
}
