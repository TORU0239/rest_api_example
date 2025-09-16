import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/post.dart';
import 'posts_notifier.dart';

final postDetailProvider =
    AutoDisposeAsyncNotifierProviderFamily<PostDetailNotifier, Post, int>(
  PostDetailNotifier.new,
);

class PostDetailNotifier extends AutoDisposeFamilyAsyncNotifier<Post, int> {
  late int _id;

  @override
  FutureOr<Post> build(int id) async {
    _id = id;
    final repository = ref.watch(postRepositoryProvider);
    return repository.fetchPost(id);
  }

  Future<void> reload() async {
    final repository = ref.read(postRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.fetchPost(_id));
  }
}
