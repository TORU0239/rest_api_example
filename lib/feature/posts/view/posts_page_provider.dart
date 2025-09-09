import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/post_repository.dart';
import '../provider/posts_provider.dart';
import 'post_detail_page_provider.dart';

class PostsPageProvider extends StatelessWidget {
  const PostsPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostsProvider(PostRepository())..load(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Posts (Provider)')),
        body: Consumer<PostsProvider>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (vm.error != null) {
              return Center(child: Text('Error: ${vm.error}'));
            }
            return ListView.separated(
              itemCount: vm.posts.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final p = vm.posts[index];
                return ListTile(
                  title: Text(p.title),
                  subtitle: Text(
                    p.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PostDetailPageProvider(id: p.id),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
