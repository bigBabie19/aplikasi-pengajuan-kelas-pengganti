import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../dashboard/data/models/recent_submission_model.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.submission,
    this.onTap,
  });

  final RecentSubmissionModel submission;
  final VoidCallback? onTap;

  Color _statusColor() {
    switch (submission.status.toLowerCase()) {
      case 'approved':
        return AppColors.success;

      case 'rejected':
        return AppColors.danger;

      default:
        return AppColors.orange;
    }
  }

  IconData _statusIcon() {
    switch (submission.status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle;

      case 'rejected':
        return Icons.cancel;

      default:
        return Icons.schedule;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: _statusColor().withOpacity(.12),
                child: Icon(
                  _statusIcon(),
                  color: _statusColor(),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      submission.courseName,
                      style: AppTextStyle.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      submission.date,
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              Chip(
                backgroundColor: _statusColor().withOpacity(.12),
                side: BorderSide.none,
                label: Text(
                  submission.status,
                  style: TextStyle(
                    color: _statusColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
