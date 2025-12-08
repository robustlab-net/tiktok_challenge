class Post {
  final String username;
  final String profileImage;
  final bool isVerified;
  final String timeAgo;
  final String? text;
  final List<String>? images;
  final int replies;
  final int likes;

  Post({
    required this.username,
    required this.profileImage,
    this.isVerified = false,
    required this.timeAgo,
    this.text,
    this.images,
    this.replies = 0,
    this.likes = 0,
  });
}
