import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/post_repository.dart';
import '../provider/post_detail_provider.dart';

class PostDetailPageProvider extends StatelessWidget {
  const PostDetailPageProvider({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostDetailProvider(PostRepository())..load(id),
      child: Scaffold(
        appBar: AppBar(title: Text('Post #$id')),
        body: Consumer<PostDetailProvider>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (vm.error != null) {
              return Center(child: Text('Error: ${vm.error}'));
            }
            final post = vm.post;
            if (post == null) {
              return const Center(child: Text('No data'));
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Text(post.body, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
