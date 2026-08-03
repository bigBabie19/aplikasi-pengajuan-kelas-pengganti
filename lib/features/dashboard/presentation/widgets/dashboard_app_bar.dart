import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../auth/providers/auth_provider.dart';

class DashboardAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    super.key,
  });

  Future<void> _logout(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Logout',
          ),
          content: const Text(
            'Apakah Anda yakin ingin keluar dari aplikasi?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'Batal',
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Logout',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    await ref
        .read(
          authNotifierProvider.notifier,
        )
        .logout();

    if (!context.mounted) {
      return;
    }

    context.go('/login');
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      title: Text(
        'Dashboard',
        style: AppTextStyle.heading,
      ),
      actions: [
        IconButton(
          tooltip: 'Logout',
          icon: const Icon(
            Icons.logout_rounded,
          ),
          onPressed: () => _logout(
            context,
            ref,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );
}
