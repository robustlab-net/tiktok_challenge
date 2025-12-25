import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_challenge/features/home/home_screen.dart';
import 'package:tiktok_challenge/features/search/search_screen.dart';
import 'package:tiktok_challenge/features/posts/posts_screen.dart';
import 'package:tiktok_challenge/features/alerts/alerts_screen.dart';
import 'package:tiktok_challenge/features/users/user_profile_screen.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';

class MainNavigationScreen extends StatefulWidget {
  final int? initialIndex;

  const MainNavigationScreen({super.key, this.initialIndex});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex ?? 0;
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    PostsScreen(),
    AlertsScreen(),
    UserProfileScreen(),
  ];

  void _onTap(int index) {
    if (index == 2) {
      // Show new thread screen as modal
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const NewThreadScreen(),
          fullscreenDialog: true,
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<DarkModeViewModel>().isDarkMode;
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDark ? Colors.black : Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: isDark ? Colors.white : Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house, size: 24),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 24),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.penToSquare, size: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              _selectedIndex == 3
                  ? FontAwesomeIcons.solidHeart
                  : FontAwesomeIcons.heart,
              size: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              _selectedIndex == 4
                  ? FontAwesomeIcons.solidUser
                  : FontAwesomeIcons.user,
              size: 24,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
