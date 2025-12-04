import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/constants/gaps.dart';
import 'package:tiktok_challenge/constants/sizes.dart';
import 'package:tiktok_challenge/features/authentication/verification_code_screen.dart';

class AccountSummaryScreen extends StatelessWidget {
  final String name;
  final String email;
  final String dateOfBirth;

  const AccountSummaryScreen({
    super.key,
    required this.name,
    required this.email,
    required this.dateOfBirth,
  });

  void _onBackTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerificationCodeScreen(
          email: email,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => _onBackTap(context),
        ),
        title: const FaIcon(
          FontAwesomeIcons.twitter,
          color: Color(0xFF1DA1F2),
          size: 30,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.v20,
                      const Text(
                        'Create your account',
                        style: TextStyle(
                          fontSize: Sizes.size28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      Gaps.v40,
                      // Name field (read-only)
                      _buildReadOnlyField('Name', name),
                      Gaps.v10,
                      // Email/Phone field (read-only)
                      _buildReadOnlyField(
                          'Phone number or email address', email),
                      Gaps.v10,
                      // Date of birth field (read-only)
                      _buildReadOnlyField('Date of birth', dateOfBirth),
                    ],
                  ),
                ),
              ),
            ),
            // Terms and privacy text
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size32,
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: Sizes.size12,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                  children: const [
                    TextSpan(text: 'By signing up, you agree to the '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: Color(0xFF1DA1F2),
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: Color(0xFF1DA1F2),
                      ),
                    ),
                    TextSpan(text: ', including '),
                    TextSpan(
                      text: 'Cookie Use',
                      style: TextStyle(
                        color: Color(0xFF1DA1F2),
                      ),
                    ),
                    TextSpan(
                      text:
                          '. Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalizing our services, including ads. ',
                    ),
                    TextSpan(
                      text: 'Learn more',
                      style: TextStyle(
                        color: Color(0xFF1DA1F2),
                      ),
                    ),
                    TextSpan(
                      text:
                          '. Others will be able to find you by email or phone number, when provided, unless you choose otherwise ',
                    ),
                    TextSpan(
                      text: 'here',
                      style: TextStyle(
                        color: Color(0xFF1DA1F2),
                      ),
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
            Gaps.v20,
            // Sign up button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size32,
                vertical: Sizes.size20,
              ),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: GestureDetector(
                  onTap: () => _onSignUpTap(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1DA1F2),
                      borderRadius: BorderRadius.circular(Sizes.size24),
                    ),
                    child: const Text(
                      'Sign up',
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: Sizes.size12,
                  ),
                ),
                Gaps.v5,
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size16,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            color: Color(0xFF34A853),
          ),
        ],
      ),
    );
  }
}
