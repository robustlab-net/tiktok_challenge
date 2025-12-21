import 'package:go_router/go_router.dart';
import 'package:tiktok_challenge/features/authentication/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_challenge/features/settings/settings_screen.dart';
import 'package:tiktok_challenge/features/settings/privacy_screen.dart';
import 'package:tiktok_challenge/features/posts/posts_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final tabParam = state.uri.queryParameters['tab'];
        final initialIndex = tabParam != null ? int.tryParse(tabParam) : null;
        return MainNavigationScreen(initialIndex: initialIndex);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/settings/privacy',
      builder: (context, state) => const PrivacyScreen(),
    ),
    GoRoute(
      path: '/new-thread',
      builder: (context, state) => const NewThreadScreen(),
    ),
  ],
);
