import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/constants/gaps.dart';
import 'package:tiktok_challenge/constants/sizes.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<String> _interests = [
    'Fashion & beauty',
    'Outdoors',
    'Arts & culture',
    'Animation\n& comics',
    'Business\n& finance',
    'Food',
    'Travel',
    'Entertainment',
    'Music',
    'Gaming',
    'Sports',
    'Technology',
  ];

  final Set<String> _selectedInterests = {};

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        _selectedInterests.add(interest);
      }
    });
  }

  void _onNextTap() {
    if (_selectedInterests.length >= 3) {
      // TODO: Navigate to next screen
      print('Selected interests: $_selectedInterests');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = _selectedInterests.length >= 3;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              Gaps.v10,
              const FaIcon(
                FontAwesomeIcons.twitter,
                color: Color(0xFF1DA1F2),
                size: 30,
              ),
              Gaps.v20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What do you want to see on Twitter?',
                      style: TextStyle(
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      'Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.v20,
            ],
          ),
        ),
        toolbarHeight: 245,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: Colors.grey.shade300,
            height: 0.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16, vertical: Sizes.size40),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _interests.map((interest) {
              final isSelected = _selectedInterests.contains(interest);
              return GestureDetector(
                onTap: () => _toggleInterest(interest),
                child: Container(
                  width: (MediaQuery.of(context).size.width - 44) / 2,
                  height: 90,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1DA1F2) : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1DA1F2)
                          : Colors.grey.shade300,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            interest,
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size32,
              vertical: Sizes.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Counter or "Great work" message
                if (isComplete)
                  const Text(
                    'Great work 🎉',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                else
                  Text(
                    '${_selectedInterests.length} of 3 selected',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                // Next button
                GestureDetector(
                  onTap: isComplete ? _onNextTap : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size32,
                      vertical: Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      color: isComplete ? Colors.black : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(Sizes.size24),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w700,
                        color: isComplete ? Colors.white : Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
