import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _selectedTab = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Activity',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
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
              child: ListView(
                children: [
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
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
                    border: Border.all(color: Colors.white, width: 2),
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
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
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
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
                // Content
                if (content != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    content!,
                    style: const TextStyle(
                      fontSize: 15,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
            color: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}


