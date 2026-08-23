import 'package:flutter/material.dart';

import '../../data/models/dashboard_model.dart';

import '../../../../core/theme/app_text_style.dart';

import 'greeting_header.dart';
import 'summary_grid.dart';
import 'lecturer_quick_menu.dart';
import 'recent_submission_section.dart';

class LecturerDashboardPlaceholder extends StatelessWidget {
  const LecturerDashboardPlaceholder({
    super.key,
    required this.dashboard,
  });

  final DashboardModel dashboard;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        GreetingHeader(
          dashboard: dashboard,
        ),
        const SizedBox(height: 20),
        SummaryGrid(
          dashboard: dashboard,
        ),
        const SizedBox(height: 24),
        const Text(
          'Menu Cepat',
          style: AppTextStyle.heading,
        ),
        const SizedBox(height: 14),
        const LecturerQuickMenu(),
        const SizedBox(height: 24),
        RecentSubmissionSection(
          dashboard: dashboard,
          showSubmitter: true,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
