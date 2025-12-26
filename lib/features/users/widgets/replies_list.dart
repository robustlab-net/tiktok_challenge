import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';
import 'package:tiktok_challenge/features/users/widgets/reply_item.dart';

class RepliesList extends ConsumerWidget {
  const RepliesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final isDark = ref.watch(darkModeProvider);
    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Column(
        children: List.generate(replies.length, (index) {
          final reply = replies[index];
          final isLast = index == replies.length - 1;
          return ReplyItem(
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
