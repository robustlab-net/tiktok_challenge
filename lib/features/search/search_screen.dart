import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade500,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // User list
            Expanded(
              child: ListView(
                children: [
                  _UserTile(
                    username: 'rjmithun',
                    displayName: 'Mithun',
                    followers: '26.6K',
                    verified: true,
                    avatarUrl: 'https://picsum.photos/100/100?random=1',
                  ),
                  _UserTile(
                    username: 'vicenews',
                    displayName: 'VICE News',
                    followers: '301K',
                    verified: true,
                    hasIcon: true,
                    avatarUrl: 'https://picsum.photos/100/100?random=2',
                  ),
                  _UserTile(
                    username: 'trevornoah',
                    displayName: 'Trevor Noah',
                    followers: '789K',
                    verified: true,
                    avatarUrl: 'https://picsum.photos/100/100?random=3',
                  ),
                  _UserTile(
                    username: 'condenasttraveller',
                    displayName: 'Condé Nast Traveller',
                    followers: '130K',
                    verified: true,
                    avatarUrl: 'https://picsum.photos/100/100?random=4',
                  ),
                  _UserTile(
                    username: 'chef_pillai',
                    displayName: 'Suresh Pillai',
                    followers: '69.2K',
                    verified: true,
                    avatarUrl: 'https://picsum.photos/100/100?random=5',
                  ),
                  _UserTile(
                    username: 'malala',
                    displayName: 'Malala Yousafzai',
                    followers: '237K',
                    verified: true,
                    hasIcon: true,
                    avatarUrl: 'https://picsum.photos/100/100?random=6',
                  ),
                  _UserTile(
                    username: 'sebin_cyriac',
                    displayName: 'Fishing_freaks',
                    followers: '53.2K',
                    verified: true,
                    avatarUrl: 'https://picsum.photos/100/100?random=7',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final String username;
  final String displayName;
  final String followers;
  final bool verified;
  final bool hasIcon;
  final String avatarUrl;

  const _UserTile({
    required this.username,
    required this.displayName,
    required this.followers,
    this.verified = false,
    this.hasIcon = false,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(width: 12),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username with verification badge
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (verified) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.verified,
                        size: 16,
                        color: Colors.blue.shade400,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                // Display name
                Text(
                  displayName,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                // Followers
                Row(
                  children: [
                    if (hasIcon) ...[
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          size: 8,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      '$followers followers',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Follow button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Follow',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
