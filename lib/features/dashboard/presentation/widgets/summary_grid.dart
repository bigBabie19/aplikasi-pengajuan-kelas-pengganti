import 'package:flutter/material.dart';

import '../../data/models/dashboard_model.dart';
import '../../../../core/theme/app_colors.dart';
import 'summary_card.dart';

class SummaryGrid extends StatelessWidget {
  const SummaryGrid({
    super.key,
    required this.dashboard,
  });

  final DashboardModel dashboard;

  @override
  Widget build(BuildContext context) {
    final summary = dashboard.summary;

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 1.15,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SummaryCard(
          title: 'Total',
          value: summary.total,
          color: AppColors.primary,
          icon: Icons.assignment_outlined,
        ),
        SummaryCard(
          title: 'Pending',
          value: summary.pending,
          color: AppColors.pending,
          icon: Icons.schedule,
        ),
        SummaryCard(
          title: 'Approved',
          value: summary.approved,
          color: AppColors.success,
          icon: Icons.check_circle_outline,
        ),
        SummaryCard(
          title: 'Rejected',
          value: summary.rejected,
          color: AppColors.danger,
          icon: Icons.cancel_outlined,
        ),
      ],
    );
  }
}
