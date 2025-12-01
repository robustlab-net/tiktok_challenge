import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/constants/gaps.dart';
import 'package:tiktok_challenge/constants/sizes.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _selectedDate = '';

  bool get _isNameValid => _nameController.text.length >= 6;

  bool get _isEmailValid {
    if (_emailController.text.isEmpty) return false;

    // Email validation
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (emailRegExp.hasMatch(_emailController.text)) {
      return true;
    }

    // Phone number validation (숫자만 10자리 이상)
    final phoneRegExp = RegExp(r'^[0-9]{10,}$');
    final digitsOnly = _emailController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (phoneRegExp.hasMatch(digitsOnly)) {
      return true;
    }

    return false;
  }

  bool get _isDateValid => _selectedDate.isNotEmpty;
  bool get _isFormValid => _isNameValid && _isEmailValid && _isDateValid;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {});
    });
    _emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onCancelTap() {
    Navigator.of(context).pop();
  }

  void _onNextTap() {
    if (_isFormValid) {
      // TODO: Navigate to Customize Experience screen
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => const CustomizeExperienceScreen(),
      //   ),
      // );
    }
  }

  void _showDatePicker() {
    DateTime initialDate = DateTime(2000, 1, 1);

    showCupertinoModalPopup(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate,
              maximumDate: DateTime.now(),
              minimumDate: DateTime(1900),
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _selectedDate =
                      '${_getMonthName(newDate.month)} ${newDate.day}, ${newDate.year}';
                });
              },
            ),
          ),
        );
      },
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: TextButton(
            onPressed: _onCancelTap,
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black,
              ),
            ),
          ),
          leadingWidth: 80,
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
                      // Name input
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: Sizes.size16,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: Sizes.size16,
                          ),
                          suffixIcon: _isNameValid
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF34A853),
                                )
                              : null,
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
                      Gaps.v10,
                      // Email or Phone input
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Phone number or email address',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: Sizes.size16,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: Sizes.size16,
                          ),
                          suffixIcon: _isEmailValid
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF34A853),
                                )
                              : null,
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
                      Gaps.v20,
                      // Date of birth
                      GestureDetector(
                        onTap: _showDatePicker,
                        child: AbsorbPointer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date of birth',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: _selectedDate.isEmpty
                                            ? Sizes.size16
                                            : Sizes.size12,
                                      ),
                                    ),
                                    if (_selectedDate.isNotEmpty) ...[
                                      Gaps.v5,
                                      Text(
                                        _selectedDate,
                                        style: const TextStyle(
                                          color: Color(0xFF1DA1F2),
                                          fontSize: Sizes.size16,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              if (_selectedDate.isNotEmpty) ...[
                                Gaps.v10,
                                Text(
                                  'This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.',
                                  style: TextStyle(
                                    fontSize: Sizes.size14,
                                    color: Colors.grey.shade600,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
              // Next button - always at bottom
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size32,
                  vertical: Sizes.size20,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: _isFormValid ? _onNextTap : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size32,
                        vertical: Sizes.size14,
                      ),
                      decoration: BoxDecoration(
                        color: _isFormValid
                            ? Colors.black
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(Sizes.size24),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
