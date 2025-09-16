import 'package:flutter/foundation.dart';

import '../../../data/models/post.dart';
import '../../../data/repositories/post_repository.dart';

class PostsProvider extends ChangeNotifier {
  PostsProvider(this._repository);

  final PostRepository _repository;

  bool _loading = false;
  String? _error;
  List<Post> _posts = const [];

  bool get isLoading => _loading;
  String? get error => _error;
  List<Post> get posts => _posts;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _posts = await _repository.fetchPosts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
