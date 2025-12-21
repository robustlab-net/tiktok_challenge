import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String _selectedTab = 'Threads';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Top navigation bar
          SliverAppBar(
            floating: true,
            backgroundColor: isDark ? Colors.black : Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.globe,
                color: isDark ? Colors.white : Colors.black,
                size: 24,
              ),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.instagram,
                  color: isDark ? Colors.white : Colors.black,
                  size: 24,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.equals,
                  color: isDark ? Colors.white : Colors.black,
                  size: 28,
                ),
                onPressed: () => context.go('/settings'),
              ),
            ],
          ),
          // Profile information
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and avatar row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Jane',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text(
                                  'jane_mobbin',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'threads.net',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Profile avatar
                        Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://picsum.photos/200/200?random=profile',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                              ),
                              child: const Center(
                                child: Text(
                                  '🪴',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Bio
                    const Text(
                      'Plant enthusiast!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Followers
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 24,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://picsum.photos/100/100?random=20',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isDark ? Colors.black : Colors.white,
                                      width: 2,
                                    ),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                        'https://picsum.photos/100/100?random=21',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '2 followers',
                          style: TextStyle(
                            fontSize: 15,
                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Edit profile',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Share profile',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
            ),
          ),
          // Tabs header
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabHeaderDelegate(
              selectedTab: _selectedTab,
              onTabChanged: (tab) {
                setState(() {
                  _selectedTab = tab;
                });
              },
            ),
          ),
          // Content based on selected tab
          if (_selectedTab == 'Threads')
            SliverList(
              delegate: SliverChildListDelegate([
                const _ThreadItem(
                  username: 'jane_mobbin',
                  timeAgo: '5h',
                  content:
                      'Give @john_mobbin a follow if you want to see more travel content!',
                  avatarUrl: 'https://picsum.photos/200/200?random=profile',
                ),
                const _ThreadItem(
                  username: 'jane_mobbin',
                  timeAgo: '6h',
                  content: 'Tea. Spillage.',
                  hasQuote: true,
                  quotedUsername: 'iwetmyyplants',
                  quotedContent:
                      'I\'m just going to say what we are all thinking and knowing is about to go downity down: There is about to be some piping hot tea spillage on here daily that people will be ...',
                  avatarUrl: 'https://picsum.photos/200/200?random=profile',
                ),
              ]),
            )
          else
            const SliverToBoxAdapter(
              child: _RepliesListView(),
            ),
        ],
      ),
    );
  }
}

class _RepliesListView extends StatelessWidget {
  const _RepliesListView();

  @override
  Widget build(BuildContext context) {
    final replies = [
      {
        'username': 'john_mobbin',
        'timeAgo': '5h',
        'content': 'Always a dream to see the Medina in Morocco!',
        'replyToUsername': 'earthpix',
        'replyToContent':
            'What is one place you\'re absolutely traveling to by next year?',
        'replyCount': '256 replies',
        'avatarUrl': 'https://picsum.photos/100/100?random=30',
      },
      {
        'username': 'jane_mobbin',
        'timeAgo': '5h',
        'content': 'See you there!',
        'replyToUsername': 'john_mobbin',
        'replyToContent': 'Meet me at the coffee shop tomorrow',
        'replyCount': null,
        'avatarUrl': 'https://picsum.photos/200/200?random=profile',
      },
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Column(
        children: List.generate(replies.length, (index) {
          final reply = replies[index];
          final isLast = index == replies.length - 1;
          return _ReplyItemConnected(
            username: reply['username']!,
            timeAgo: reply['timeAgo']!,
            content: reply['content']!,
            replyToUsername: reply['replyToUsername']!,
            replyToContent: reply['replyToContent']!,
            replyCount: reply['replyCount'],
            avatarUrl: reply['avatarUrl']!,
            showConnector: !isLast,
          );
        }),
      ),
    );
  }
}

class _TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String selectedTab;
  final Function(String) onTabChanged;

  _TabHeaderDelegate({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Column(
        children: [
          Container(
            height: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged('Threads'),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTab == 'Threads'
                              ? (isDark ? Colors.white : Colors.black)
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Threads',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 'Threads'
                              ? (isDark ? Colors.white : Colors.black)
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged('Replies'),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTab == 'Replies'
                              ? (isDark ? Colors.white : Colors.black)
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Replies',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 'Replies'
                              ? (isDark ? Colors.white : Colors.black)
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 49;

  @override
  double get minExtent => 49;

  @override
  bool shouldRebuild(covariant _TabHeaderDelegate oldDelegate) {
    return selectedTab != oldDelegate.selectedTab;
  }
}

class _ThreadItem extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String content;
  final String avatarUrl;
  final bool hasQuote;
  final String? quotedUsername;
  final String? quotedContent;

  const _ThreadItem({
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.avatarUrl,
    this.hasQuote = false,
    this.quotedUsername,
    this.quotedContent,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          timeAgo,
                          style: TextStyle(
                            fontSize: 15,
                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.more_horiz,
                          size: 20,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Thread content
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                if (hasQuote && quotedContent != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 10,
                              backgroundImage: NetworkImage(
                                'https://picsum.photos/100/100?random=40',
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              quotedUsername ?? '',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified,
                              size: 14,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          quotedContent ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://picsum.photos/400/300?random=100',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                // Actions
                const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.heart,
                      size: 20,
                    ),
                    SizedBox(width: 16),
                    FaIcon(
                      FontAwesomeIcons.comment,
                      size: 20,
                    ),
                    SizedBox(width: 16),
                    FaIcon(
                      FontAwesomeIcons.repeat,
                      size: 20,
                    ),
                    SizedBox(width: 16),
                    FaIcon(
                      FontAwesomeIcons.paperPlane,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReplyItemConnected extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String content;
  final String replyToUsername;
  final String replyToContent;
  final String? replyCount;
  final String avatarUrl;
  final bool showConnector;

  const _ReplyItemConnected({
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.replyToUsername,
    required this.replyToContent,
    this.replyCount,
    required this.avatarUrl,
    this.showConnector = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar with connector line
          Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              if (showConnector)
                Container(
                  width: 2,
                  height: 160,
                  margin: const EdgeInsets.only(top: 8),
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          timeAgo,
                          style: TextStyle(
                            fontSize: 15,
                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.more_horiz,
                          size: 20,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Reply content
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                // Original thread
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(
                              'https://picsum.photos/100/100?random=50',
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            replyToUsername,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified,
                            size: 14,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        replyToContent,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      if (replyCount != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          replyCount!,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Actions
                const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.heart,
                      size: 20,
                    ),
                    SizedBox(width: 16),
                    FaIcon(
                      FontAwesomeIcons.comment,
                      size: 20,
                    ),
                    SizedBox(width: 16),
                    FaIcon(
                      FontAwesomeIcons.repeat,
                      size: 20,
                    ),
                    SizedBox(width: 16),
                    FaIcon(
                      FontAwesomeIcons.paperPlane,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
