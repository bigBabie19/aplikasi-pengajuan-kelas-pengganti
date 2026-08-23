import 'package:flutter/material.dart';

import '../../data/models/dashboard_model.dart';
import '../../../../core/theme/app_text_style.dart';
import 'recent_submission_card.dart';
import 'recent_submission_empty.dart';

class RecentSubmissionSection extends StatelessWidget {
  const RecentSubmissionSection({
    super.key,
    required this.dashboard,
    this.showSubmitter = false,
  });

  final DashboardModel dashboard;
  final bool showSubmitter;

  @override
  Widget build(BuildContext context) {
    final submissions = dashboard.recentSubmissions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Submission',
          style: AppTextStyle.heading,
        ),
        const SizedBox(height: 14),
        if (submissions.isEmpty)
          const RecentSubmissionEmpty()
        else
          Column(
            children: submissions
                .map(
                  (submission) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: 14,
                    ),
                    child: RecentSubmissionCard(
                      submission: submission,
                      showSubmitter: showSubmitter,
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
