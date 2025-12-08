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
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                      height: 24,
                      child: Stack(
                        children: [
                          Positioned(
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
                        Icon(
                          Icons.more_horiz,
                          color: Colors.grey.shade600,
                          size: 20,
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                height: 300,
                                child: PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentImageIndex = index;
                                    });
                                  },
                                  itemCount: widget.post.images!.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      widget.post.images![index],
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
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
