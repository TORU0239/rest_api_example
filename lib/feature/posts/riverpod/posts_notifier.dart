import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/post.dart';
import '../../../data/repositories/post_repository.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  // Create a repository instance per scope so HTTP clients can be shared
  // across Riverpod providers and easily mocked in tests.
  return PostRepository();
});

final postsProvider =
    AutoDisposeAsyncNotifierProvider<PostsNotifier, List<Post>>(
  PostsNotifier.new,
);

class PostsNotifier extends AutoDisposeAsyncNotifier<List<Post>> {
  @override
  FutureOr<List<Post>> build() async {
    final repository = ref.watch(postRepositoryProvider);
    return repository.fetchPosts();
  }

  Future<void> reload() async {
    final repository = ref.read(postRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(repository.fetchPosts);
  }
}
