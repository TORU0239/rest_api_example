import 'package:dio/dio.dart';

import '../models/post.dart';
import '../network/api_client.dart';
import '../network/network_exceptions.dart';

class PostRepository {
  factory PostRepository({Dio? dio, ApiClient? apiClient}) {
    final dioInstance = dio ?? Dio();
    // Set sane defaults and a friendly User-Agent; some public APIs 403 unknown clients
    dioInstance.options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=utf-8',
      'User-Agent': 'rest_api_example/1.0 (Dio HTTP Client)',
    });
    // Add basic logging to aid debugging
    if (!dioInstance.interceptors.any((i) => i is LogInterceptor)) {
      dioInstance.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
    final apiInstance = apiClient ?? ApiClient(dioInstance);
    return PostRepository._(dioInstance, apiInstance);
  }

  PostRepository._(this._dio, this._api);

  final Dio _dio;
  final ApiClient _api;

  Dio get dio => _dio;
  ApiClient get api => _api;

  Future<List<Post>> fetchPosts() async {
    try {
      return await _api.getPosts();
    } on DioException catch (e) {
      throw mapDioException(e);
    } catch (_) {
      throw const NetworkException('Unexpected error occurred.');
    }
  }

  Future<Post> fetchPost(int id) async {
    try {
      return await _api.getPost(id);
    } on DioException catch (e) {
      throw mapDioException(e);
    } catch (_) {
      throw const NetworkException('Unexpected error occurred.');
    }
  }
}
