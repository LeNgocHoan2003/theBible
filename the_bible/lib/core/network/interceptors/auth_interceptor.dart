import 'package:dio/dio.dart';

import 'package:the_bible/core/network/storage/local_storage.dart';

/// Adds `Authorization: Bearer <token>` to outgoing requests when a token is stored.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.localStorage});

  final LocalStorage localStorage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip attaching token when request explicitly does not require auth.
    if (options.headers['requiresAuth'] == false) {
      return handler.next(options);
    }

    try {
      final token = await localStorage.getToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      // Do not reject request from interceptor token read failures.
      // Keep request flowing and handle auth errors from API responses.
    }

    handler.next(options);
  }
}