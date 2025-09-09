import 'package:equatable/equatable.dart';
import '../../../data/models/post.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsLoaded extends PostsState {
  const PostsLoaded(this.posts);
  final List<Post> posts;

  @override
  List<Object?> get props => [posts];
}

class PostsError extends PostsState {
  const PostsError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

