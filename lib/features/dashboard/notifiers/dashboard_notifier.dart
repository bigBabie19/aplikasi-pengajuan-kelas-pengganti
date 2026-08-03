import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/dashboard_repository.dart';
import '../state/dashboard_state.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier(this._repository) : super(const DashboardState()) {
    loadDashboard();
  }

  final DashboardRepository _repository;

  bool _loaded = false;

  Future<void> loadDashboard({
    bool forceRefresh = false,
  }) async {
    if (_loaded && !forceRefresh && state.dashboard != null) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    final result = await _repository.getDashboard();

    if (!result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        error: result.error,
      );
      return;
    }

    _loaded = true;

    state = state.copyWith(
      isLoading: false,
      dashboard: result.data,
      clearError: true,
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isRefreshing: true,
      clearError: true,
    );

    final result = await _repository.getDashboard();

    if (!result.isSuccess) {
      state = state.copyWith(
        isRefreshing: false,
        error: result.error,
      );
      return;
    }

    _loaded = true;

    state = state.copyWith(
      dashboard: result.data,
      isRefreshing: false,
      clearError: true,
    );
  }
}
