import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/post_detail_notifier.dart';

class PostDetailPageRiverpod extends ConsumerWidget {
  const PostDetailPageRiverpod({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(postDetailProvider(id));

    return Scaffold(
      appBar: AppBar(title: Text('Post #$id')),
      body: postAsync.when(
        data: (post) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text(post.body, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () =>
                    ref.read(postDetailProvider(id).notifier).reload(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
