import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/features/home/models/post_model.dart';
import 'package:tiktok_challenge/features/home/widgets/post_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        text: 'Elon alone on Twitter right now...',
        images: ['https://picsum.photos/400/400?random=2'],
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
        text: 'Photoshoot with Molly pup. :)',
        images: ['https://picsum.photos/400/400?random=6'],
        replies: 53,
        likes: 437,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              floating: false,
              pinned: false,
              centerTitle: true,
              title: FaIcon(
                FontAwesomeIcons.at,
                color: Colors.black,
                size: 32,
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
