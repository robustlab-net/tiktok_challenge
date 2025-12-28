import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_challenge/features/authentication/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_challenge/features/authentication/threads_login_screen.dart';
import 'package:tiktok_challenge/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_challenge/features/settings/settings_screen.dart';
import 'package:tiktok_challenge/features/settings/privacy_screen.dart';
import 'package:tiktok_challenge/features/posts/posts_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != '/signup') {
          return '/signup';
        }
      }
      return null;
    },
    routes: [
    // 인증 화면
    GoRoute(
      path: '/signup',
      builder: (context, state) => const ThreadsLoginScreen(),
    ),
    // Bottom navigation이 올라가는 메인 탭들
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const MainNavigationScreen(initialIndex: 0), // Home
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) =>
          const MainNavigationScreen(initialIndex: 1), // Search
    ),
    GoRoute(
      path: '/activity',
      builder: (context, state) =>
          const MainNavigationScreen(initialIndex: 3), // Activity(Alerts)
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) =>
          const MainNavigationScreen(initialIndex: 4), // Profile
    ),
    // Settings 관련
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/settings/privacy',
      builder: (context, state) => const PrivacyScreen(),
    ),
    // 쓰기 화면은 기존처럼 모달로도 쓰고, URL로도 접근 가능
    GoRoute(
      path: '/new-thread',
      builder: (context, state) => const NewThreadScreen(),
    ),
  ],
  );
});
