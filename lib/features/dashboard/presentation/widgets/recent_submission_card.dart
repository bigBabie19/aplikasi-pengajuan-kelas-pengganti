import 'package:flutter/material.dart';

import '../../data/models/recent_submission_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import 'recent_submission_status.dart';

class RecentSubmissionCard extends StatelessWidget {
  const RecentSubmissionCard({
    super.key,
    required this.submission,
    this.showSubmitter = false,
  });

  final RecentSubmissionModel submission;
  final bool showSubmitter;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      submission.courseName,
                      style: AppTextStyle.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  RecentSubmissionStatus(
                    status: submission.status,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      submission.lecturer,
                      style: AppTextStyle.body,
                    ),
                  ),
                ],
              ),
              if (showSubmitter) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        submission.submitter,
                        style: AppTextStyle.body,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.meeting_room_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      submission.room,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${submission.day}, ${submission.date}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      submission.time,
                    ),
                  ),
                ],
              ),
              if (submission.status == 'rejected' &&
                  submission.approvalReason != null) ...[
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    submission.approvalReason!,
                    style: TextStyle(
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
