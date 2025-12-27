import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_challenge/constants/gaps.dart';
import 'package:tiktok_challenge/constants/sizes.dart';
import 'package:tiktok_challenge/features/authentication/create_account_screen.dart';
import 'package:tiktok_challenge/features/authentication/view_models/auth_view_model.dart';

class ThreadsLoginScreen extends ConsumerStatefulWidget {
  const ThreadsLoginScreen({super.key});

  @override
  ConsumerState<ThreadsLoginScreen> createState() =>
      _ThreadsLoginScreenState();
}

class _ThreadsLoginScreenState extends ConsumerState<ThreadsLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginTap() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }

    final success = await ref.read(authProvider.notifier).login(
          email: _emailController.text,
          password: _passwordController.text,
        );

    if (success) {
      if (mounted) {
        context.go('/');
      }
    } else {
      final error = ref.read(authProvider).error;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? '로그인에 실패했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _onCreateAccountTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateAccountScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size32),
          child: Column(
            children: [
              Gaps.v20,
              // Language selector
              const Text(
                'English (US)',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              // Threads logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    '@',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Gaps.v60,
              // Email/Phone input
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Mobile number or email',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: Sizes.size16,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.size12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.size12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.size12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size16,
                    vertical: Sizes.size16,
                  ),
                ),
              ),
              Gaps.v12,
              // Password input
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: Sizes.size16,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.size12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.size12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.size12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size16,
                    vertical: Sizes.size16,
                  ),
                ),
              ),
              Gaps.v16,
              // Log in button
              GestureDetector(
                onTap: _onLoginTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0095F6),
                    borderRadius: BorderRadius.circular(Sizes.size12),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Gaps.v20,
              // Forgot password
              const Text(
                'Forgot password?',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              // Create new account button
              GestureDetector(
                onTap: _onCreateAccountTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(Sizes.size12),
                  ),
                  child: const Text(
                    'Create new account',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Gaps.v32,
              // Meta logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.apps,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                  Gaps.h5,
                  Text(
                    'Meta',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Gaps.v32,
            ],
          ),
        ),
      ),
    );
  }
}
