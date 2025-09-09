import 'package:dio/dio.dart';

import '../models/post.dart';
import '../network/api_client.dart';

class PostRepository {
  PostRepository({Dio? dio, ApiClient? apiClient})
      : _dio = dio ?? Dio(),
        _api = apiClient ?? ApiClient(dio ?? Dio());

  final Dio _dio;
  final ApiClient _api;

  Dio get dio => _dio;
  ApiClient get api => _api;

  Future<List<Post>> fetchPosts() => _api.getPosts();
  Future<Post> fetchPost(int id) => _api.getPost(id);
}

