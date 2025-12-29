import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_challenge/features/posts/repos/post_repository.dart';

class PostViewModel extends AsyncNotifier<void> {
  late final PostRepository _postRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _postRepo = ref.read(postRepoProvider);
    _authRepo = ref.read(authRepo);
  }

  // 게시물 생성
  Future<void> createPost({
    required String text,
    File? imageFile,
  }) async {
    state = const AsyncValue.loading();

    final user = _authRepo.user;
    if (user == null) {
      state = AsyncValue.error(
        Exception('User not logged in'),
        StackTrace.current,
      );
      return;
    }

    state = await AsyncValue.guard(
      () async => await _postRepo.createPost(
        text: text,
        userId: user.uid,
        imageFile: imageFile,
      ),
    );
  }

  // 게시물 삭제
  Future<void> deletePost(String postId, String? imageUrl) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _postRepo.deletePost(postId, imageUrl),
    );
  }

  // 좋아요
  Future<void> likePost(String postId) async {
    await _postRepo.likePost(postId);
  }
}

final postProvider = AsyncNotifierProvider<PostViewModel, void>(
  () => PostViewModel(),
);

// 모든 게시물 스트림
final postsStreamProvider = StreamProvider((ref) {
  final postRepo = ref.watch(postRepoProvider);
  return postRepo.getPosts();
});

// 특정 사용자 게시물 스트림
final userPostsStreamProvider = StreamProvider.family((ref, String userId) {
  final postRepo = ref.watch(postRepoProvider);
  return postRepo.getUserPosts(userId);
});
