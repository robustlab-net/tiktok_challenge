import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/constants/gaps.dart';
import 'package:tiktok_challenge/constants/sizes.dart';
import 'package:tiktok_challenge/features/authentication/username_screen.dart';
import 'package:tiktok_challenge/features/authentication/login_screen.dart';
import 'package:tiktok_challenge/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  void _onCreateAccountTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gaps.v60,
                // Twitter logo
                const FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Color(0xFF1DA1F2),
                  size: 40,
                ),
                Gaps.v120,
                // Main heading
                const Text(
                  "See what's happening\nin the world right now.",
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gaps.v120,
                // Continue with Google button
                GestureDetector(
                  onTap: () => _onEmailTap(context),
                  child: const AuthButton(
                    icon: FaIcon(FontAwesomeIcons.google),
                    text: "Continue with Google",
                  ),
                ),
                Gaps.v16,
                // Continue with Apple button
                const AuthButton(
                  icon: FaIcon(FontAwesomeIcons.apple),
                  text: "Continue with Apple",
                ),
                Gaps.v24,
                // Separator with "or"
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size16,
                      ),
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
                Gaps.v10,
                // Create account button (black)
                GestureDetector(
                  onTap: () => _onCreateAccountTap(context),
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(Sizes.size24),
                      ),
                      child: const Text(
                        'Create account',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Gaps.v20,
                // Terms and Privacy text
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        color: Colors.grey.shade600,
                      ),
                      children: const [
                        TextSpan(text: 'By signing up, you agree to our '),
                        TextSpan(
                          text: 'Terms',
                          style: TextStyle(
                            color: Color(0xFF1DA1F2),
                          ),
                        ),
                        TextSpan(text: ', '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Color(0xFF1DA1F2),
                          ),
                        ),
                        TextSpan(text: ', and '),
                        TextSpan(
                          text: 'Cookie Use',
                          style: TextStyle(
                            color: Color(0xFF1DA1F2),
                          ),
                        ),
                        TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
                Gaps.v40,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size32,
            horizontal: Sizes.size40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black87,
                ),
              ),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onLoginTap(context),
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
