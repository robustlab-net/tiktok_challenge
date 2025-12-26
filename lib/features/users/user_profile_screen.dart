import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';
import 'package:tiktok_challenge/features/users/widgets/profile_header.dart';
import 'package:tiktok_challenge/features/users/widgets/profile_tab_header.dart';
import 'package:tiktok_challenge/features/users/widgets/thread_item.dart';
import 'package:tiktok_challenge/features/users/widgets/replies_list.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  String _selectedTab = 'Threads';

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(darkModeProvider);
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
          const SliverToBoxAdapter(
            child: ProfileHeader(),
          ),
          // Tabs header
          SliverPersistentHeader(
            pinned: true,
            delegate: ProfileTabHeader(
              selectedTab: _selectedTab,
              isDark: isDark,
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
                const ThreadItem(
                  username: 'jane_mobbin',
                  timeAgo: '5h',
                  content:
                      'Give @john_mobbin a follow if you want to see more travel content!',
                  avatarUrl: 'https://picsum.photos/200/200?random=profile',
                ),
                const ThreadItem(
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
              child: RepliesList(),
            ),
        ],
      ),
    );
  }
}
