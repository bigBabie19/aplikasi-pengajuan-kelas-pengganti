import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasource/dashboard_remote_datasource.dart';
import '../data/repositories/dashboard_repository.dart';
import '../notifiers/dashboard_notifier.dart';
import '../state/dashboard_state.dart';

final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>(
  (ref) => DashboardRemoteDataSource(),
);

final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepository(
    remoteDataSource: ref.read(
      dashboardRemoteDataSourceProvider,
    ),
  ),
);

final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>(
  (ref) => DashboardNotifier(
    ref.read(
      dashboardRepositoryProvider,
    ),
  ),
);
