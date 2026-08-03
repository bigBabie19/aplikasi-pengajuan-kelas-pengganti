import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import 'dashboard_navigation_item.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.current,
  });

  final DashboardNavigationItem current;

  int get _index {
    switch (current) {
      case DashboardNavigationItem.dashboard:
        return 0;
      case DashboardNavigationItem.pengajuan:
        return 1;
      case DashboardNavigationItem.riwayat:
        return 2;
      case DashboardNavigationItem.profil:
        return 3;
    }
  }

  void _onTap(
    BuildContext context,
    int index,
  ) {
    switch (index) {
      case 0:
        context.goNamed('dashboard');
        break;

      case 1:
        context.pushNamed('pengajuan');
        break;

      case 2:
        context.goNamed('history');
        break;

      case 3:
        context.goNamed('profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: AppColors.card,
        indicatorColor: AppColors.primary.withOpacity(.12),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : AppColors.subtitle,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => AppTextStyle.caption.copyWith(
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : AppColors.subtitle,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: _index,
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          _onTap(
            context,
            index,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon: Icon(Icons.edit_note),
            label: 'Pengajuan',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
