import 'dart:io';

import 'package:dio/dio.dart';

class NetworkException implements Exception {
  const NetworkException(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

NetworkException mapDioException(DioException e) {
  final code = e.response?.statusCode;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return const NetworkException(
        'Connection timed out. Please check your network and try again.',
      );
    case DioExceptionType.connectionError:
      return const NetworkException('No internet connection.');
    case DioExceptionType.badCertificate:
      return const NetworkException(
        'Secure connection failed due to a certificate error.',
      );
    case DioExceptionType.cancel:
      return const NetworkException('Request was cancelled.');
    case DioExceptionType.badResponse:
      // Map common HTTP status codes to friendly messages
      if (code != null) {
        if (code == 400) {
          return const NetworkException('Bad request.');
        }
        if (code == 401) {
          return const NetworkException('Unauthorized. Please log in.');
        }
        if (code == 403) {
          return const NetworkException('Forbidden. You do not have access.');
        }
        if (code == 404) {
          return const NetworkException('Not found.');
        }
        if (code >= 500 && code < 600) {
          return const NetworkException(
              'Server error. Please try again later.');
        }
        return NetworkException('Request failed with status code $code.',
            statusCode: code);
      }
      return const NetworkException(
          'Request failed with an unknown server error.');
    case DioExceptionType.unknown:
      if (e.error is SocketException) {
        return const NetworkException('No internet connection.');
      }
      return NetworkException(e.message ?? 'Unexpected network error.');
  }
}
