import 'package:flutter/material.dart';
import 'package:tiktok_challenge/features/authentication/birthday_screen.dart';
import 'package:tiktok_challenge/features/authentication/interests_screen.dart';
import 'package:tiktok_challenge/features/authentication/login_screen.dart';
import 'package:tiktok_challenge/features/authentication/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_challenge/features/authentication/password_screen.dart';
import 'package:tiktok_challenge/features/authentication/sign_up_screen.dart';
import 'package:tiktok_challenge/features/authentication/twitter_password_screen.dart';
import 'package:tiktok_challenge/features/authentication/verification_code_screen.dart';

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
      home: const MainNavigationScreen(),
    );
  }
}
