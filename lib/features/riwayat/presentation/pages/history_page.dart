import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

import '../../providers/history_provider.dart';
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
      ref.read(historyNotifierProvider.notifier).loadHistory();
    });
  }

  Future<void> _refresh() async {
    await ref.read(historyNotifierProvider.notifier).loadHistory(
          forceRefresh: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historyNotifierProvider);

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
          if (state.isLoading && state.submissions.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state.error != null && state.submissions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.danger,
                    size: 50,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.error!,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.body.copyWith(
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(
                            historyNotifierProvider.notifier,
                          )
                          .loadHistory(
                            forceRefresh: true,
                          );
                    },
                    child: const Text(
                      'Coba Lagi',
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: HistoryList(
              submissions: state.submissions,
            ),
          );
        },
      ),
    );
  }
}
