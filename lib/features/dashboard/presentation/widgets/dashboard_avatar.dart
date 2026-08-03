import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class DashboardAvatar extends StatelessWidget {
  const DashboardAvatar({
    super.key,
    required this.name,
    this.avatarUrl,
  });

  final String name;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(avatarUrl!),
      );
    }

    final initial = name.trim().isEmpty ? 'U' : name[0].toUpperCase();

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          initial,
          style: AppTextStyle.heading.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
