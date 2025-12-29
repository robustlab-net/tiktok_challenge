import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/posts/models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // 게시물 생성
  Future<void> createPost({
    required String text,
    required String userId,
    required String username,
    File? imageFile,
  }) async {
    try {
      String? imageUrl;

      // 이미지가 있으면 Firebase Storage에 업로드
      if (imageFile != null) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final storageRef = _storage.ref().child('posts/$userId/$timestamp.jpg');
        final uploadTask = await storageRef.putFile(imageFile);
        imageUrl = await uploadTask.ref.getDownloadURL();
      }

      // Firestore에 게시물 저장
      await _firestore.collection('posts').add({
        'text': text,
        'imageUrl': imageUrl,
        'userId': userId,
        'username': username,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'likes': 0,
        'comments': 0,
      });
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  // 모든 게시물 가져오기 (최신순)
  Stream<List<PostModel>> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return PostModel.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  // 특정 사용자의 게시물 가져오기
  Stream<List<PostModel>> getUserPosts(String userId) {
    return _firestore
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return PostModel.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  // 게시물 삭제
  Future<void> deletePost(String postId, String? imageUrl) async {
    try {
      // 이미지가 있으면 Storage에서 삭제
      if (imageUrl != null && imageUrl.isNotEmpty) {
        final imageRef = _storage.refFromURL(imageUrl);
        await imageRef.delete();
      }

      // Firestore에서 게시물 삭제
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }

  // 좋아요 수 증가
  Future<void> likePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to like post: $e');
    }
  }
}

final postRepoProvider = Provider((ref) => PostRepository());
