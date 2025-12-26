import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/home/models/post_model.dart';
import 'package:tiktok_challenge/features/home/widgets/post_widget.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(darkModeProvider);
    final posts = [
      Post(
        username: 'pubity',
        profileImage: 'https://picsum.photos/100/100?random=1',
        isVerified: true,
        timeAgo: '2m',
        text: 'Vine after seeing the Threads logo unveiled',
        images: ['https://picsum.photos/400/400?random=1'],
        replies: 36,
        likes: 391,
      ),
      Post(
        username: 'thetinderblog',
        profileImage: 'https://picsum.photos/100/100?random=2',
        isVerified: false,
        timeAgo: '5m',
        text: 'Amazing sunset views from my trip! Swipe to see more 📸',
        images: [
          'https://picsum.photos/400/400?random=10',
          'https://picsum.photos/400/400?random=11',
          'https://picsum.photos/400/400?random=12',
          'https://picsum.photos/400/400?random=13',
        ],
        replies: 64,
        likes: 631,
      ),
      Post(
        username: 'tropicalseductions',
        profileImage: 'https://picsum.photos/100/100?random=3',
        isVerified: true,
        timeAgo: '2h',
        text: 'Drop a comment here to test things out.',
        replies: 2,
        likes: 4,
      ),
      Post(
        username: 'shityoushouldcareabout',
        profileImage: 'https://picsum.photos/100/100?random=4',
        isVerified: true,
        timeAgo: '2h',
        text: 'my phone feels like a vibrator with all these notifications rn',
        replies: 64,
        likes: 631,
      ),
      Post(
        username: '_plantswithkrystal_',
        profileImage: 'https://picsum.photos/100/100?random=5',
        isVerified: true,
        timeAgo: '2h',
        text:
            'If you\'re reading this, go water that thirsty plant. You\'re welcome 😊',
        replies: 8,
        likes: 74,
      ),
      Post(
        username: 'timferriss',
        profileImage: 'https://picsum.photos/100/100?random=6',
        isVerified: true,
        timeAgo: '7h',
        text: 'Photo collection from today\'s adventure 🌟',
        images: [
          'https://picsum.photos/400/400?random=20',
          'https://picsum.photos/400/400?random=21',
          'https://picsum.photos/400/400?random=22',
        ],
        replies: 53,
        likes: 437,
      ),
      Post(
        username: 'naturephotography',
        profileImage: 'https://picsum.photos/100/100?random=7',
        isVerified: true,
        timeAgo: '10h',
        text: 'Beautiful morning captures! Slide through for more →',
        images: [
          'https://picsum.photos/400/400?random=30',
          'https://picsum.photos/400/400?random=31',
        ],
        replies: 28,
        likes: 245,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: isDark ? Colors.black : Colors.white,
              surfaceTintColor: isDark ? Colors.black : Colors.white,
              elevation: 0,
              floating: false,
              pinned: true,
              expandedHeight: 80,
              collapsedHeight: 56,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate icon size based on available height
                  const double maxHeight = 80;
                  const double minHeight = 56;
                  final double currentHeight = constraints.maxHeight;

                  // Interpolate icon size between 32 (expanded) and 24 (collapsed)
                  final double iconSize = 24 +
                      (8 *
                          ((currentHeight - minHeight) /
                              (maxHeight - minHeight)));

                  // Position icon at top when collapsed
                  final double topPadding = currentHeight < maxHeight ? 16 : 24;

                  return Container(
                    color: isDark ? Colors.black : Colors.white,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: topPadding),
                    child: FaIcon(
                      FontAwesomeIcons.at,
                      color: isDark ? Colors.white : Colors.black,
                      size: iconSize.clamp(24, 32),
                    ),
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return PostWidget(post: posts[index]);
                },
                childCount: posts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
