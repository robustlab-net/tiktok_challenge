class PostModel {
  final String id;
  final String text;
  final String? imageUrl;
  final String userId;
  final String username;
  final int createdAt;
  final int likes;
  final int comments;

  PostModel({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.userId,
    required this.username,
    required this.createdAt,
    this.likes = 0,
    this.comments = 0,
  });

  // Firestore에서 데이터를 가져올 때
  factory PostModel.fromJson(Map<String, dynamic> json, String id) {
    return PostModel(
      id: id,
      text: json['text'] as String,
      imageUrl: json['imageUrl'] as String?,
      userId: json['userId'] as String,
      username: json['username'] as String? ?? 'Anonymous',
      createdAt: json['createdAt'] as int,
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
    );
  }

  // Firestore에 저장할 때
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'imageUrl': imageUrl,
      'userId': userId,
      'username': username,
      'createdAt': createdAt,
      'likes': likes,
      'comments': comments,
    };
  }

  // 복사본 생성
  PostModel copyWith({
    String? id,
    String? text,
    String? imageUrl,
    String? userId,
    String? username,
    int? createdAt,
    int? likes,
    int? comments,
  }) {
    return PostModel(
      id: id ?? this.id,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}
