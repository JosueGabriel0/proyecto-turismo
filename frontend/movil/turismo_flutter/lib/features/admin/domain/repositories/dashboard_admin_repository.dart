import 'package:turismo_flutter/features/admin/data/models/dashboard_admin_response.dart';

abstract class DashboardAdminRepository {
  Future<DashboardAdminResponse> fetchDashboard();
}