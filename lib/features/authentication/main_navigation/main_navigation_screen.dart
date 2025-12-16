import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/features/home/home_screen.dart';
import 'package:tiktok_challenge/features/search/search_screen.dart';
import 'package:tiktok_challenge/features/posts/posts_screen.dart';
import 'package:tiktok_challenge/features/alerts/alerts_screen.dart';
import 'package:tiktok_challenge/features/users/user_profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

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
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: Colors.black,
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
