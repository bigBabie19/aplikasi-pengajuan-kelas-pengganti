import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import 'quick_menu_item.dart';

class QuickMenu extends StatelessWidget {
  const QuickMenu({
    super.key,
  });

  void _placeholder(
    BuildContext context,
    String feature,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$feature akan tersedia pada paket berikutnya.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuickMenuItem(
          title: 'Ajukan Kelas Pengganti',
          subtitle: 'Buat pengajuan baru',
          icon: Icons.add_circle_outline,
          color: AppColors.orange,
          onTap: () {
            context.pushNamed('pengajuan');
          },
        ),
        const SizedBox(height: 14),
        QuickMenuItem(
            title: 'Riwayat Pengajuan',
            subtitle: 'Lihat seluruh pengajuan',
            icon: Icons.history,
            color: AppColors.primary,
            onTap: () {
              context.pushNamed('history');
            }),
        const SizedBox(height: 14),
        QuickMenuItem(
            title: 'Profil',
            subtitle: 'Informasi akun',
            icon: Icons.person_outline,
            color: AppColors.success,
            onTap: () {
              context.pushNamed('profile');
            }),
      ],
    );
  }
}
