import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/splash_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/pengajuan/presentation/pages/pengajuan_page.dart';
import '../features/riwayat/presentation/pages/history_page.dart';
import '../features/riwayat/presentation/pages/history_detail_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      name: 'dashboard',
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/pengajuan',
      name: 'pengajuan',
      builder: (context, state) => const PengajuanPage(),
    ),
    GoRoute(
      name: 'history',
      path: '/history',
      builder: (_, __) => const HistoryPage(),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      builder: (_, __) => const ProfilePage(),
    ),
    GoRoute(
      path: '/history/:id',
      name: 'history-detail',
      builder: (context, state) {
        return HistoryDetailPage(
          id: int.parse(
            state.pathParameters['id']!,
          ),
        );
      },
    ),
  ],
);
