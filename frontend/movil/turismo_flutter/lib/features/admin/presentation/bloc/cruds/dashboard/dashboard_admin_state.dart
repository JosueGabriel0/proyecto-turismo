import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/dashboard_admin_response.dart';

abstract class DashboardAdminState extends Equatable {
  const DashboardAdminState();

  @override
  List<Object?> get props => [];
}

class DashboardAdminInitial extends DashboardAdminState {}

class DashboardAdminLoading extends DashboardAdminState {}

class DashboardAdminLoaded extends DashboardAdminState {
  final DashboardAdminResponse dashboard;

  const DashboardAdminLoaded(this.dashboard);

  @override
  List<Object?> get props => [dashboard];
}

class DashboardAdminError extends DashboardAdminState {
  final String message;

  const DashboardAdminError(this.message);

  @override
  List<Object?> get props => [message];
}