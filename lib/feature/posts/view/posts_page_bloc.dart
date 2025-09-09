import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/post_repository.dart';
import '../bloc/posts_bloc.dart';
import '../bloc/posts_event.dart';
import '../bloc/posts_state.dart';
import 'post_detail_page_bloc.dart';

class PostsPageBloc extends StatelessWidget {
  const PostsPageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsBloc(PostRepository())..add(const LoadPosts()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Posts (Bloc)')),
        body: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            switch (state) {
              case PostsInitial():
                return const SizedBox.shrink();
              case PostsLoading():
                return const Center(child: CircularProgressIndicator());
              case PostsLoaded(posts: final posts):
                return ListView.separated(
                  itemCount: posts.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final p = posts[index];
                    return ListTile(
                      title: Text(p.title),
                      subtitle: Text(
                        p.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PostDetailPageBloc(id: p.id),
                        ),
                      ),
                    );
                  },
                );
              case PostsError(message: final msg):
                return Center(
                  child: Text('Error: $msg'),
                );
            }
          },
        ),
      ),
    );
  }
}
