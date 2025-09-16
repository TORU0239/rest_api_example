import 'package:equatable/equatable.dart';
import '../../../data/models/post.dart';

sealed class PostDetailState extends Equatable {
  const PostDetailState();

  @override
  List<Object?> get props => [];
}

class PostDetailInitial extends PostDetailState {
  const PostDetailInitial();
}

class PostDetailLoading extends PostDetailState {
  const PostDetailLoading();
}

class PostDetailLoaded extends PostDetailState {
  const PostDetailLoaded(this.post);
  final Post post;

  @override
  List<Object?> get props => [post];
}

class PostDetailError extends PostDetailState {
  const PostDetailError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
