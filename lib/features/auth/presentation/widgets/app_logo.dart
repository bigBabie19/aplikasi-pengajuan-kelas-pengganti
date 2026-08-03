import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.school_rounded,
            color: Colors.white,
            size: 42,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Esa Unggul',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Pengajuan Kelas Pengganti',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.subtitle,
          ),
        ),
      ],
    );
  }
}
