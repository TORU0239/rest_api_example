import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/post_repository.dart';
import '../bloc/post_detail_bloc.dart';
import '../bloc/post_detail_event.dart';
import '../bloc/post_detail_state.dart';

class PostDetailPageBloc extends StatelessWidget {
  const PostDetailPageBloc({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostDetailBloc(PostRepository())..add(LoadPostDetail(id)),
      child: Scaffold(
        appBar: AppBar(title: Text('Post #$id')),
        body: BlocBuilder<PostDetailBloc, PostDetailState>(
          builder: (context, state) {
            switch (state) {
              case PostDetailInitial():
                return const SizedBox.shrink();
              case PostDetailLoading():
                return const Center(child: CircularProgressIndicator());
              case PostDetailLoaded(post: final post):
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      Text(post.body,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                );
              case PostDetailError(message: final msg):
                return Center(child: Text('Error: $msg'));
            }
          },
        ),
      ),
    );
  }
}
