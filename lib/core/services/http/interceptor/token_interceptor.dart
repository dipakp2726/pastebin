import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:pastebin/core/services/storage/storage_service.dart';


class TokenInterceptor extends Interceptor {
  TokenInterceptor(this.storageService);

  @visibleForTesting
  final String tokenKey = 'token_key';

  final StorageService storageService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = storageService.get(tokenKey);

    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      log('❌ ❌ ❌ Auth token expired');

      final token = await refreshToken();

      await storageService.set(tokenKey, token);

      err.requestOptions.headers['Authorization'] = 'Bearer $token';

      return handler.resolve(await Dio().fetch(err.requestOptions));
    }

    super.onError(err, handler);
  }
}

/// get access token
@visibleForTesting
Future<String> refreshToken() async {
  /// TODO: should refresh token

  return '';
}
