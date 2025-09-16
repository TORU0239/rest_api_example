import 'package:equatable/equatable.dart';

sealed class PostDetailEvent extends Equatable {
  const PostDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadPostDetail extends PostDetailEvent {
  const LoadPostDetail(this.id);
  final int id;

  @override
  List<Object?> get props => [id];
}
