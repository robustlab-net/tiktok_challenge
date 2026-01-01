import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';
import 'package:tiktok_challenge/features/search/view_models/search_view_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      ref.read(searchQueryProvider.notifier).state = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatTimeAgo(int timestamp) {
    final now = DateTime.now();
    final postTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = now.difference(postTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(darkModeProvider);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black,
                ),
                backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                prefixInsets: const EdgeInsets.symmetric(horizontal: 12),
                suffixInsets: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            const SizedBox(height: 16),
            // Search results
            Expanded(
              child: ref.watch(searchResultsProvider).when(
                data: (posts) {
                  if (posts.isEmpty) {
                    return Center(
                      child: Text(
                        _searchController.text.isEmpty
                            ? 'Search for posts'
                            : 'No posts found',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: posts.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    ),
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Anonymous avatar
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                'https://picsum.photos/100/100?random=anonymous',
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Post content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header
                                  Row(
                                    children: [
                                      Text(
                                        post.username,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        _formatTimeAgo(post.createdAt),
                                        style: TextStyle(
                                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  // Text content
                                  Text(
                                    post.text,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  // Image if exists
                                  if (post.imageUrl != null) ...[
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        post.imageUrl!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Container(
                                            height: 200,
                                            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                                            child: const Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );
                                        },
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            height: 200,
                                            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                                            child: const Center(
                                              child: Icon(Icons.error),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
