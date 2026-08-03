import '../data/models/dashboard_model.dart';

class DashboardState {
  final bool isLoading;
  final bool isRefreshing;
  final DashboardModel? dashboard;
  final String? error;

  const DashboardState({
    this.isLoading = false,
    this.isRefreshing = false,
    this.dashboard,
    this.error,
  });

  DashboardState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    DashboardModel? dashboard,
    String? error,
    bool clearDashboard = false,
    bool clearError = false,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      dashboard: clearDashboard ? null : dashboard ?? this.dashboard,
      error: clearError ? null : error ?? this.error,
    );
  }
}
