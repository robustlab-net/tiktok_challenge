import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/home/data/mock_posts.dart';
import 'package:tiktok_challenge/features/home/widgets/home_app_bar.dart';
import 'package:tiktok_challenge/features/home/widgets/post_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const HomeAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return PostWidget(post: mockPosts[index]);
                },
                childCount: mockPosts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
