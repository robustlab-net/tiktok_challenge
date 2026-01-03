import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/posts/models/post_model.dart';

class SearchRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 검색어로 게시물 필터링
  Stream<List<PostModel>> searchPosts(String query) {
    if (query.isEmpty) {
      // 검색어가 없으면 모든 게시물 반환
      return _firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => PostModel.fromJson(doc.data(), doc.id))
                .toList(),
          );
    }

    // 검색어가 있으면 텍스트 필드에서 검색
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PostModel.fromJson(doc.data(), doc.id))
              .where((post) =>
                  post.text.toLowerCase().contains(query.toLowerCase()))
              .toList(),
        );
  }
}

final searchRepoProvider = Provider((ref) => SearchRepository());
