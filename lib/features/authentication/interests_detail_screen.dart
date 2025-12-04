import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/constants/gaps.dart';
import 'package:tiktok_challenge/constants/sizes.dart';

class InterestsDetailScreen extends StatefulWidget {
  const InterestsDetailScreen({super.key});

  @override
  State<InterestsDetailScreen> createState() => _InterestsDetailScreenState();
}

class _InterestsDetailScreenState extends State<InterestsDetailScreen> {
  final Map<String, List<String>> _categoryInterests = {
    'Music': [
      'Rap',
      'R&B & soul',
      'Grammy Awards',
      'Pop',
      'K-pop',
      'Music industry',
      'EDM',
      'Music news',
      'Hip hop',
      'Reggae',
    ],
    'Entertainment': [
      'Anime',
      'Movies & TV',
      'Harry Potter',
      'Marvel Universe',
      'Movie news',
      'Naruto',
      'Movies',
      'Grammy Awards',
      'Entertainment',
    ],
  };

  final Set<String> _selectedInterests = {};

  void _onBackTap(BuildContext context) {
    Navigator.of(context).pop();
  }

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
    // TODO: Navigate to next screen or finish
    print('Selected detailed interests: $_selectedInterests');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v20,
                  const Text(
                    'What do you want to see on Twitter?',
                    style: TextStyle(
                      fontSize: Sizes.size28,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  Gaps.v10,
                  Text(
                    'Interests are used to personalize your experience and will be visible on your profile.',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                  Gaps.v20,
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.grey.shade300,
            ),
            Gaps.v24,
            // Build each category section
            ..._categoryInterests.entries
                .toList()
                .asMap()
                .entries
                .map((mapEntry) {
              final index = mapEntry.key;
              final entry = mapEntry.value;
              final isLastCategory = index == _categoryInterests.length - 1;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: const TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Gaps.v16,
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: entry.value.map((interest) {
                            final isSelected =
                                _selectedInterests.contains(interest);
                            return GestureDetector(
                              onTap: () => _toggleInterest(interest),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size16,
                                  vertical: Sizes.size12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF1DA1F2)
                                      : Colors.white,
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF1DA1F2)
                                        : Colors.grey.shade300,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  interest,
                                  style: TextStyle(
                                    fontSize: Sizes.size14,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  if (!isLastCategory) ...[
                    Gaps.v32,
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: Colors.grey.shade300,
                    ),
                    Gaps.v32,
                  ] else
                    Gaps.v32,
                ],
              );
            }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
              child: Column(
                children: [
                  Gaps.v40,
                ],
              ),
            ),
          ],
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
                const SizedBox.shrink(),
                GestureDetector(
                  onTap: _onNextTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size32,
                      vertical: Sizes.size14,
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
