import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/dashboard_model.dart';
import 'dashboard_avatar.dart';
import 'dashboard_notification.dart';
import 'today_date_text.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.dashboard,
  });

  final DashboardModel dashboard;

  @override
  Widget build(BuildContext context) {
    final user = dashboard.user;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              DashboardAvatar(
                name: user.name,
                avatarUrl: user.avatarUrl,
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: TodayDateText(),
              ),
              const DashboardNotification(),
            ],
          ),
          const SizedBox(height: 22),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Halo, ${user.name}',
              style: AppTextStyle.heading.copyWith(
                color: AppColors.text,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Selamat datang kembali',
              style: AppTextStyle.body.copyWith(
                color: AppColors.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
