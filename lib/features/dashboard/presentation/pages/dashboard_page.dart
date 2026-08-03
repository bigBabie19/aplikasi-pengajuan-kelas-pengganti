import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/dashboard_provider.dart';
import '../widgets/dashboard_app_bar.dart';
import '../widgets/dashboard_error.dart';
import '../widgets/dashboard_loading.dart';
import '../widgets/dashboard_placeholder.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/dashboard_navigation_item.dart';
import '../../../../core/theme/app_colors.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref.read(dashboardNotifierProvider.notifier).loadDashboard();
    });
  }

  Future<void> _refresh() async {
    await ref.read(dashboardNotifierProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      dashboardNotifierProvider,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const DashboardAppBar(),
      bottomNavigationBar: const AppBottomNavigation(
        current: DashboardNavigationItem.dashboard,
      ),
      body: RefreshIndicator(
        displacement: 24,
        onRefresh: _refresh,
        child: Builder(
          builder: (_) {
            if (state.isLoading && state.dashboard == null) {
              return const DashboardLoading();
            }

            if (state.error != null && state.dashboard == null) {
              return DashboardError(
                message: state.error!,
                onRetry: () async {
                  await ref
                      .read(
                        dashboardNotifierProvider.notifier,
                      )
                      .loadDashboard(
                        forceRefresh: true,
                      );
                },
              );
            }

            final dashboard = state.dashboard;

            if (dashboard == null) {
              return const SizedBox.shrink();
            }

            return DashboardPlaceholder(
              dashboard: dashboard,
            );
          },
        ),
      ),
    );
  }
}
