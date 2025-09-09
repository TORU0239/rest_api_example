part of 'api_client.dart';

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {String? baseUrl}) {
    if (baseUrl != null) {
      _dio.options.baseUrl = baseUrl;
    } else if (_dio.options.baseUrl.isEmpty) {
      _dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
    }
  }

  final Dio _dio;

  @override
  Future<List<Post>> getPosts() async {
    final response = await _dio.get<dynamic>('/posts');
    final data = response.data as List<dynamic>;
    return data.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<Post> getPost(int id) async {
    final response = await _dio.get<dynamic>('/posts/$id');
    final data = response.data as Map<String, dynamic>;
    return Post.fromJson(data);
  }
}
