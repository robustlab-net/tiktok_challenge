import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _selectedTab = 'All';

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<DarkModeViewModel>().isDarkMode;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Activity',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            // Tab buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _TabButton(
                      label: 'All',
                      isSelected: _selectedTab == 'All',
                      onTap: () {
                        setState(() {
                          _selectedTab = 'All';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _TabButton(
                      label: 'Replies',
                      isSelected: _selectedTab == 'Replies',
                      onTap: () {
                        setState(() {
                          _selectedTab = 'Replies';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _TabButton(
                      label: 'Mentions',
                      isSelected: _selectedTab == 'Mentions',
                      onTap: () {
                        setState(() {
                          _selectedTab = 'Mentions';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _TabButton(
                      label: 'Verified',
                      isSelected: _selectedTab == 'Verified',
                      onTap: () {
                        setState(() {
                          _selectedTab = 'Verified';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Activity list
            Expanded(
              child: _selectedTab == 'All'
                  ? ListView(
                      children: const [
                        _ActivityItem(
                          username: 'john_mobbin',
                          timeAgo: '4h',
                          activityType: 'Mentioned you',
                          badgeColor: Colors.green,
                          badgeIcon: Icons.alternate_email,
                          content:
                              "Here's a thread you should follow if you love botany @jane_mobbin",
                          avatarUrl: 'https://picsum.photos/100/100?random=10',
                        ),
                        _ActivityItem(
                          username: 'john_mobbin',
                          timeAgo: '4h',
                          activityType:
                              'Starting out my gardening club with thr...',
                          badgeColor: Colors.blue,
                          badgeIcon: Icons.forum,
                          content: 'Count me in!',
                          avatarUrl: 'https://picsum.photos/100/100?random=10',
                        ),
                        _ActivityItem(
                          username: 'the.plantdads',
                          timeAgo: '5h',
                          activityType: 'Followed you',
                          badgeColor: Colors.purple,
                          badgeIcon: Icons.person_add,
                          showFollowButton: true,
                          avatarUrl: 'https://picsum.photos/100/100?random=11',
                        ),
                        _ActivityItem(
                          username: 'the.plantdads',
                          timeAgo: '5h',
                          activityType: '',
                          badgeColor: Colors.pink,
                          badgeIcon: Icons.favorite,
                          content: 'Definitely broken! 👔👀🌱',
                          avatarUrl: 'https://picsum.photos/100/100?random=11',
                        ),
                        _ActivityItem(
                          username: 'theberryjungle',
                          timeAgo: '5h',
                          activityType: '',
                          badgeColor: Colors.pink,
                          badgeIcon: Icons.favorite,
                          content: '🌱👀👔',
                          avatarUrl: 'https://picsum.photos/100/100?random=12',
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        _selectedTab,
                        style: TextStyle(
                          fontSize: 18,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
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

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<DarkModeViewModel>().isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? Colors.white : Colors.black)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? (isDark ? Colors.white : Colors.black)
                : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? (isDark ? Colors.black : Colors.white)
                  : (isDark ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String activityType;
  final Color badgeColor;
  final IconData badgeIcon;
  final String? content;
  final bool showFollowButton;
  final String avatarUrl;

  const _ActivityItem({
    required this.username,
    required this.timeAgo,
    required this.activityType,
    required this.badgeColor,
    required this.badgeIcon,
    this.content,
    this.showFollowButton = false,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<DarkModeViewModel>().isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with badge
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: badgeColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? Colors.black : Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        badgeIcon,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username and time
                    Row(
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          timeAgo,
                          style: TextStyle(
                            fontSize: 15,
                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    // Activity type
                    if (activityType.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        activityType,
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                    // Content
                    if (content != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        content!,
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Follow button
              if (showFollowButton) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ],
          ),
          // Border line with left padding
          Container(
            margin: const EdgeInsets.only(left: 60, top: 12),
            height: 0.5,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
