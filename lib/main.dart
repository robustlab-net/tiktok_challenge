import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_challenge/features/settings/repositories/dark_mode_repository.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';
import 'package:tiktok_challenge/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final darkModeRepository = DarkModeRepository(preferences);

  runApp(
    ChangeNotifierProvider(
      create: (context) => DarkModeViewModel(darkModeRepository),
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TikTok Clone',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF1DA1F2),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFF1DA1F2),
        useMaterial3: true,
      ),
      themeMode: context.watch<DarkModeViewModel>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      routerConfig: router,
    );
  }
}
