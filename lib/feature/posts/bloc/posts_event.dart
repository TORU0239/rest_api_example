import 'package:equatable/equatable.dart';

sealed class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostsEvent {
  const LoadPosts();
}
