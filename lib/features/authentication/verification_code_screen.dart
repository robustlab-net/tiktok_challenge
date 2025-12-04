import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/constants/gaps.dart';
import 'package:tiktok_challenge/constants/sizes.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;

  const VerificationCodeScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isCodeComplete = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      _controllers[i].addListener(_onCodeChanged);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged() {
    final isComplete = _controllers.every((controller) => controller.text.isNotEmpty);
    if (isComplete != _isCodeComplete) {
      setState(() {
        _isCodeComplete = isComplete;
      });
    }
  }

  void _onBackTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onNextTap() {
    if (_isCodeComplete) {
      final code = _controllers.map((c) => c.text).join();
      // TODO: Handle verification
      print('Verification code: $code');
    }
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty) {
      // Move to next field
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last field, unfocus
        _focusNodes[index].unfocus();
      }
    }
  }

  void _onDigitDeleted(int index) {
    if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              const Text(
                'We sent you a code',
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              Gaps.v16,
              Text(
                'Enter it below to verify\n${widget.email}.',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              Gaps.v40,
              // 6-digit input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 45,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF1DA1F2),
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _onDigitChanged(index, value);
                        }
                      },
                      onTap: () {
                        // Clear the field when tapped
                        _controllers[index].clear();
                      },
                      onEditingComplete: () {
                        if (_controllers[index].text.isEmpty && index > 0) {
                          _onDigitDeleted(index);
                        }
                      },
                    ),
                  ),
                ),
              ),
              Gaps.v40,

              const Spacer(),
              GestureDetector(
                onTap: () {
                  // TODO: Handle resend email
                },
                child: const Text(
                  "Didn't receive email?",
                  style: TextStyle(
                    color: Color(0xFF1DA1F2),
                    fontSize: Sizes.size14,
                  ),
                ),
              ),
              // Next button
              Gaps.v14,
              FractionallySizedBox(
                widthFactor: 1,
                child: GestureDetector(
                  onTap: _isCodeComplete ? _onNextTap : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size16,
                    ),
                    decoration: BoxDecoration(
                      color: _isCodeComplete
                          ? const Color(0xFF1DA1F2)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(Sizes.size24),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w700,
                        color: _isCodeComplete ? Colors.white : Colors.grey.shade500,
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
