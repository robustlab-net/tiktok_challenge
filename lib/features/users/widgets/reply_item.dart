import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';

class ReplyItem extends ConsumerWidget {
  final String username;
  final String timeAgo;
  final String content;
  final String replyToUsername;
  final String replyToContent;
  final String? replyCount;
  final String avatarUrl;
  final bool showConnector;

  const ReplyItem({
    super.key,
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(darkModeProvider);
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
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.more_horiz,
                          size: 20,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
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
                      color:
                          isDark ? Colors.grey.shade700 : Colors.grey.shade300,
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
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
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
