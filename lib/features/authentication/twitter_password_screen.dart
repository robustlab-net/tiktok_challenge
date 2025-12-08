import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/constants/gaps.dart';
import 'package:tiktok_challenge/constants/sizes.dart';
import 'package:tiktok_challenge/features/authentication/interests_screen.dart';

class TwitterPasswordScreen extends StatefulWidget {
  const TwitterPasswordScreen({super.key});

  @override
  State<TwitterPasswordScreen> createState() => _TwitterPasswordScreenState();
}

class _TwitterPasswordScreenState extends State<TwitterPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    setState(() {
      _isPasswordValid = _passwordController.text.length >= 8;
    });
  }

  void _onBackTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onNextTap() {
    if (_isPasswordValid) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const InterestsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const FaIcon(
          FontAwesomeIcons.twitter,
          color: Color(0xFF1DA1F2),
          size: 30,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              const Text(
                "You'll need a password",
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              Gaps.v14,
              Text(
                "Make sure it's 8 characters or more.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              Gaps.v24,
              // Password input field
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                ),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: Sizes.size16,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: Sizes.size1,
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade400,
                          size: 24,
                        ),
                      ),
                      if (_isPasswordValid) ...[
                        Gaps.h10,
                        const Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Color(0xFF34A853),
                              size: 24,
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              size: 12,
                            ),
                          ],
                        ),
                      ],
                      Gaps.h10,
                    ],
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF1DA1F2),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // Next button
              FractionallySizedBox(
                widthFactor: 1,
                child: GestureDetector(
                  onTap: _isPasswordValid ? _onNextTap : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size16,
                    ),
                    decoration: BoxDecoration(
                      color: _isPasswordValid
                          ? Colors.black
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(Sizes.size24),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w700,
                        color: _isPasswordValid
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Gaps.v20,
            ],
          ),
        ),
      ),
    );
  }
}
