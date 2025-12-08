import 'package:flutter/material.dart';
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
        text: 'If you\'re reading this, go water that thirsty plant. You\'re welcome 😊',
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Icon(
          Icons.diamond_outlined,
          color: Colors.black,
          size: 32,
        ),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostWidget(post: posts[index]);
        },
      ),
    );
  }
}
