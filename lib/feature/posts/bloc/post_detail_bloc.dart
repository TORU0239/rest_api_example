import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/post_repository.dart';
import 'post_detail_event.dart';
import 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  PostDetailBloc(this._repository) : super(const PostDetailInitial()) {
    on<LoadPostDetail>(_onLoad);
  }

  final PostRepository _repository;

  Future<void> _onLoad(
    LoadPostDetail event,
    Emitter<PostDetailState> emit,
  ) async {
    emit(const PostDetailLoading());
    try {
      final post = await _repository.fetchPost(event.id);
      emit(PostDetailLoaded(post));
    } catch (e) {
      emit(PostDetailError(e.toString()));
    }
  }
}

