import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../dashboard/providers/dashboard_provider.dart';
import '../widgets/history_list.dart';
import '../../../dashboard/presentation/widgets/app_bottom_navigation.dart';
import '../../../dashboard/presentation/widgets/dashboard_navigation_item.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({
    super.key,
  });

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(
            dashboardNotifierProvider.notifier,
          )
          .loadDashboard(
            forceRefresh: true,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      dashboardNotifierProvider,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNavigation(
        current: DashboardNavigationItem.riwayat,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        title: Text(
          'Riwayat Pengajuan',
          style: AppTextStyle.heading.copyWith(
            color: AppColors.text,
          ),
        ),
      ),
      body: Builder(
        builder: (_) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.dashboard == null) {
            return const Center(
              child: Text(
                'Data tidak tersedia.',
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              return ref
                  .read(
                    dashboardNotifierProvider.notifier,
                  )
                  .refresh();
            },
            child: HistoryList(
              submissions: state.dashboard!.recentSubmissions,
            ),
          );
        },
      ),
    );
  }
}
