import 'package:flutter/foundation.dart';

import '../../../data/models/post.dart';
import '../../../data/repositories/post_repository.dart';

class PostDetailProvider extends ChangeNotifier {
  PostDetailProvider(this._repository);

  final PostRepository _repository;

  bool _loading = false;
  String? _error;
  Post? _post;

  bool get isLoading => _loading;
  String? get error => _error;
  Post? get post => _post;

  Future<void> load(int id) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _post = await _repository.fetchPost(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
