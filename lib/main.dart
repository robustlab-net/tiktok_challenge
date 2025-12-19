import 'package:flutter/material.dart';
import 'package:tiktok_challenge/router.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TikTok Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFF1DA1F2), // Twitter blue
      ),
      routerConfig: router,
    );
  }
}
