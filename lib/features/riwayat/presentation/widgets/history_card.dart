import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/history_submission_model.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.submission,
    this.onTap,
  });

  final HistorySubmissionModel submission;
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
    final color = _statusColor();

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
                backgroundColor: color.withOpacity(.12),
                child: Icon(
                  _statusIcon(),
                  color: color,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      submission.courseClass,
                      style: AppTextStyle.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      submission.submitter,
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.subtitle,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      submission.room,
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.subtitle,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${submission.replacementDate} • '
                      '${submission.startTime} - '
                      '${submission.endTime}',
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Chip(
                backgroundColor: color.withOpacity(.12),
                side: BorderSide.none,
                label: Text(
                  submission.status.toUpperCase(),
                  style: TextStyle(
                    color: color,
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
