import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_challenge/features/home/models/post_model.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({
    super.key,
    required this.post,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late final PageController _pageController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction:
          widget.post.images != null && widget.post.images!.length > 1
              ? 0.92
              : 1.0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) => _PostOptionsSheet(username: widget.post.username),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasStats = widget.post.replies > 0 || widget.post.likes > 0;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Profile, line, and reply avatars
              Column(
                children: [
                  // Profile image with plus icon
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.post.profileImage),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Vertical line (dynamic height)
                  if (hasStats)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  // Reply avatars at bottom
                  if (hasStats)
                    SizedBox(
                      width: 40,
                      height: widget.post.replies > 10 ? 38 : 24,
                      child: Stack(
                        children: [
                          if (widget.post.replies > 10)
                            Positioned(
                              top: 0,
                              left: 12,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                ),
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundImage: NetworkImage(
                                    'https://picsum.photos/50/50?random=${widget.post.username}3',
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: 0,
                            left: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: CircleAvatar(
                                radius: 10,
                                backgroundImage: NetworkImage(
                                  'https://picsum.photos/50/50?random=${widget.post.username}1',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 18,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: CircleAvatar(
                                radius: 10,
                                backgroundImage: NetworkImage(
                                  'https://picsum.photos/50/50?random=${widget.post.username}2',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 10),
              // Right side - Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        // Username and verified badge
                        Row(
                          children: [
                            Text(
                              widget.post.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            if (widget.post.isVerified) ...[
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.verified,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ],
                          ],
                        ),
                        const Spacer(),
                        // Time and menu
                        Text(
                          widget.post.timeAgo,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _showPostOptions(context),
                          child: Icon(
                            Icons.more_horiz,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Text content
                    if (widget.post.text != null)
                      Text(
                        widget.post.text!,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                    // Images
                    if (widget.post.images != null &&
                        widget.post.images!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 300,
                              child: PageView.builder(
                                controller: _pageController,
                                padEnds: false,
                                pageSnapping: true,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentImageIndex = index;
                                  });
                                },
                                itemCount: widget.post.images!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        widget.post.images![index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (widget.post.images!.length > 1)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    widget.post.images!.length,
                                    (index) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentImageIndex == index
                                            ? Colors.blue
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 12),
                    // Action buttons
                    const Row(
                      children: [
                        FaIcon(FontAwesomeIcons.heart, size: 20),
                        SizedBox(width: 16),
                        FaIcon(FontAwesomeIcons.comment, size: 20),
                        SizedBox(width: 16),
                        FaIcon(FontAwesomeIcons.repeat, size: 20),
                        SizedBox(width: 16),
                        FaIcon(FontAwesomeIcons.paperPlane, size: 20),
                      ],
                    ),
                    // Stats text
                    if (hasStats)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          '${widget.post.replies} replies · ${widget.post.likes} likes',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Bottom Sheet for Post Options
class _PostOptionsSheet extends StatefulWidget {
  final String username;

  const _PostOptionsSheet({required this.username});

  @override
  State<_PostOptionsSheet> createState() => _PostOptionsSheetState();
}

class _PostOptionsSheetState extends State<_PostOptionsSheet> {
  bool _showReportScreen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _showReportScreen
          ? _ReportScreen(
              onBack: () => setState(() => _showReportScreen = false),
            )
          : _buildMainOptions(),
    );
  }

  Widget _buildMainOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Group 1: Unfollow, Mute
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                children: [
                  _OptionTile(
                    title: 'Unfollow',
                    onTap: () {
                      Navigator.pop(context);
                      // Handle unfollow
                    },
                  ),
                  Divider(height: 1, color: Colors.grey.shade200, thickness: 1),
                  _OptionTile(
                    title: 'Mute',
                    onTap: () {
                      Navigator.pop(context);
                      // Handle mute
                    },
                  ),
                ],
              ),
            ),
          ),
          // Group 2: Hide, Report
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                children: [
                  _OptionTile(
                    title: 'Hide',
                    onTap: () {
                      Navigator.pop(context);
                      // Handle hide
                    },
                  ),
                  Divider(height: 1, color: Colors.grey.shade200, thickness: 1),
                  _OptionTile(
                    title: 'Report',
                    isDestructive: true,
                    onTap: () => setState(() => _showReportScreen = true),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// Report Screen
class _ReportScreen extends StatelessWidget {
  final VoidCallback onBack;

  const _ReportScreen({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title
          const Text(
            'Report',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          // Report content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const Text(
                  'Why are you reporting this thread?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                _ReportOptionTile(
                  title: "I just don't like it",
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: "It's unlawful content under NetzDG",
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: "It's spam",
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: 'Hate speech or symbols',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: 'Nudity or sexual activity',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: 'False information',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: 'Scam or fraud',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: 'Violence or dangerous organisations',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: 'Bullying or harassment',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: 'Intellectual property violation',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: 'Sale of illegal or regulated goods',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: 'Suicide or self-injury',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                _ReportOptionTile(
                  title: 'Eating disorders',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle report
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Option Tile for main options
class _OptionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _OptionTile({
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        color: Colors.grey.shade100,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isDestructive ? Colors.red : Colors.black,
          ),
        ),
      ),
    );
  }
}

// Report Option Tile
class _ReportOptionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ReportOptionTile({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }
}
