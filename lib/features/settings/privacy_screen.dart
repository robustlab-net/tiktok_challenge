import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';

class PrivacyScreen extends ConsumerStatefulWidget {
  const PrivacyScreen({super.key});

  @override
  ConsumerState<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends ConsumerState<PrivacyScreen> {
  bool _privateProfile = true;

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(darkModeProvider);
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        leadingWidth: 80,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.go('/settings'),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_back_ios,
                color: isDark ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 2),
              Text(
                'Back',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          'Privacy',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          Divider(height: 1, color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Icon(
              Icons.lock_outline,
              size: 28,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Private profile',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: CupertinoSwitch(
              value: _privateProfile,
              onChanged: (value) {
                setState(() {
                  _privateProfile = value;
                });
              },
              activeTrackColor: isDark ? Colors.white : Colors.black,
            ),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Icon(
              Icons.alternate_email,
              size: 28,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Mentions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Everyone',
                  style: TextStyle(
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                ),
              ],
            ),
            onTap: () {
              // TODO: Navigate to mentions settings
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Icon(
              Icons.volume_off_outlined,
              size: 28,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Muted',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 20,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
            ),
            onTap: () {
              // TODO: Navigate to muted accounts
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Icon(
              Icons.visibility_off_outlined,
              size: 28,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Hidden Words',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 20,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
            ),
            onTap: () {
              // TODO: Navigate to hidden words
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Icon(
              Icons.people_outline,
              size: 28,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Profiles you follow',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 20,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
            ),
            onTap: () {
              // TODO: Navigate to profiles you follow
            },
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Other privacy settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Icon(
              Icons.block_outlined,
              size: 28,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Blocked profiles',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.open_in_new,
              size: 20,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
            ),
            onTap: () {
              // TODO: Navigate to blocked profiles (Instagram)
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Icon(
              Icons.favorite_border,
              size: 28,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Hide likes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.open_in_new,
              size: 20,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
            ),
            onTap: () {
              // TODO: Navigate to hide likes (Instagram)
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
