import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/providers/auth_provider.dart';
import 'dashboard_page.dart';
import 'lecturer_dashboard_page.dart';

class RoleDashboardPage extends ConsumerWidget {
  const RoleDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final role = authState.user?.role;

    if (role == 'mahasiswa') {
      return const DashboardPage();
    }

    if (role == 'dosen') {
      return const LecturerDashboardPage();
    }

    return const Scaffold(
      body: Center(
        child: Text(
          'Role pengguna tidak dikenali.',
        ),
      ),
    );
  }
}
