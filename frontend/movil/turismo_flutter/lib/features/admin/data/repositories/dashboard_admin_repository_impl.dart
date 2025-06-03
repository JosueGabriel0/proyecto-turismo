import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/dashboard_admin_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/dashboard_admin_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/dashboard_admin_repository.dart';

class DashboardAdminRepositoryImpl implements DashboardAdminRepository {
  final DashboardAdminApiClient apiClient;

  DashboardAdminRepositoryImpl(this.apiClient);

  @override
  Future<DashboardAdminResponse> fetchDashboard() {
    return apiClient.getDashboard();
  }
}