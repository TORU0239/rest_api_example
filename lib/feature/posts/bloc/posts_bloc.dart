import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/post_repository.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc(this._repository) : super(const PostsInitial()) {
    on<LoadPosts>(_onLoadPosts);
  }

  final PostRepository _repository;

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostsState> emit) async {
    emit(const PostsLoading());
    try {
      final posts = await _repository.fetchPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}

