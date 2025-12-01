import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/constants/gaps.dart';
import 'package:tiktok_challenge/constants/sizes.dart';
import 'package:tiktok_challenge/features/authentication/account_summary_screen.dart';

class CustomizeExperienceScreen extends StatefulWidget {
  final String name;
  final String email;
  final String dateOfBirth;

  const CustomizeExperienceScreen({
    super.key,
    required this.name,
    required this.email,
    required this.dateOfBirth,
  });

  @override
  State<CustomizeExperienceScreen> createState() =>
      _CustomizeExperienceScreenState();
}

class _CustomizeExperienceScreenState extends State<CustomizeExperienceScreen> {
  bool _trackingEnabled = true;

  void _onBackTap() {
    Navigator.of(context).pop();
  }

  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AccountSummaryScreen(
          name: widget.name,
          email: widget.email,
          dateOfBirth: widget.dateOfBirth,
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
          onPressed: _onBackTap,
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
                      Gaps.v40,
                      const Text(
                        'Customize your experience',
                        style: TextStyle(
                          fontSize: Sizes.size28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      Gaps.v32,
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Track where you see Twitter content across the web',
                              style: TextStyle(
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                height: 1.2,
                              ),
                            ),
                          ),
                          Gaps.h16,

                        ],
                      ),
                      Gaps.v16,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.',
                              style: TextStyle(
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),
                          ),
                          Gaps.h16,
                          CupertinoSwitch(
                            value: _trackingEnabled,
                            onChanged: (value) {
                              setState(() {
                                _trackingEnabled = value;
                              });
                            },
                            activeColor: const Color(0xFF34A853),
                          ),
                        ],
                      ),
                      Gaps.v20,
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: Sizes.size12,
                            color: Colors.grey.shade600,
                            height: 1.4,
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
                            TextSpan(
                              text:
                                  '. Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. ',
                            ),
                            TextSpan(
                              text: 'Learn more',
                              style: TextStyle(
                                color: Color(0xFF1DA1F2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Next button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size32,
                vertical: Sizes.size20,
              ),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: GestureDetector(
                  onTap: _onNextTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(Sizes.size24),
                    ),
                    child: const Text(
                      'Next',
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
}
