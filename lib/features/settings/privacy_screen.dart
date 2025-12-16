import 'package:flutter/material.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _privateProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Privacy',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: _privateProfile,
            onChanged: (value) {
              setState(() {
                _privateProfile = value;
              });
            },
            title: const Text(
              'Private profile',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            secondary: const Icon(Icons.lock_outline),
            activeColor: Colors.black,
          ),
          ListTile(
            leading: const Icon(Icons.alternate_email),
            title: const Text('Mentions'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Everyone',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {
              // TODO: Navigate to mentions settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.volume_off_outlined),
            title: const Text('Muted'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to muted accounts
            },
          ),
          ListTile(
            leading: const Icon(Icons.visibility_off_outlined),
            title: const Text('Hidden Words'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to hidden words
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Profiles you follow'),
            trailing: const Icon(Icons.chevron_right),
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
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.block_outlined),
            title: const Text('Blocked profiles'),
            trailing: const Icon(Icons.open_in_new, size: 20),
            onTap: () {
              // TODO: Navigate to blocked profiles (Instagram)
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Hide likes'),
            trailing: const Icon(Icons.open_in_new, size: 20),
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
