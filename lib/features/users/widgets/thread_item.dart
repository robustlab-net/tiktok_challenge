import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';

class ThreadItem extends ConsumerWidget {
  final String username;
  final String timeAgo;
  final String content;
  final String avatarUrl;
  final bool hasQuote;
  final String? quotedUsername;
  final String? quotedContent;

  const ThreadItem({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.avatarUrl,
    this.hasQuote = false,
    this.quotedUsername,
    this.quotedContent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(darkModeProvider);
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
                        color: isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
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
