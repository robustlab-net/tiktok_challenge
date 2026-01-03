import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/posts/models/post_model.dart';
import 'package:tiktok_challenge/features/search/repos/search_repository.dart';

// 검색어 상태 관리
final searchQueryProvider = StateProvider<String>((ref) => '');

// 검색 결과 스트림 (검색어에 따라 자동으로 업데이트)
final searchResultsProvider = StreamProvider<List<PostModel>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final searchRepo = ref.watch(searchRepoProvider);

  return searchRepo.searchPosts(query);
});
