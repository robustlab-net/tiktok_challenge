import 'package:flutter/material.dart';
import 'package:tiktok_challenge/features/authentication/sign_up_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFF1DA1F2), // Twitter blue
      ),
      home: const SignUpScreen(),
    );
  }
}
