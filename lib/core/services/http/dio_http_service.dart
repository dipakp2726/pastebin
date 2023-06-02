import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pastebin/core/configs/configs.dart';
import 'package:pastebin/core/exceptions/http_exception.dart';
import 'package:pastebin/core/services/http/http_service.dart';
import 'package:pastebin/core/services/http/interceptor/token_interceptor.dart';
import 'package:pastebin/core/services/storage/storage_service.dart';

/// Http service implementation using the Dio package
///
/// See https://pub.dev/packages/dio
class DioHttpService implements HttpService {
  /// Creates new instance of [DioHttpService]
  DioHttpService(
    this.storageService, {
    Dio? dioOverride,
  }) {
    dio = dioOverride ?? Dio(baseOptions);
    dio.interceptors.add(TokenInterceptor(storageService));
  }

  /// Storage service used for caching http responses
  final StorageService storageService;

  /// The Dio Http client
  late final Dio dio;

  /// The Dio base options
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => Configs.apiBaseUrl;

  @override
  Map<String, String> headers = {
    'accept': 'application/json',
    'content-type': 'application/json'
  };

  @override
  Future<Map<String, dynamic>> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        bool forceRefresh = false,
        String? customBaseUrl,
      }) async {
    try {
      final Response<dynamic> response = await dio.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: queryParameters,
      );

      return response.data as Map<String, dynamic>;
    } on DioError catch (e) {
      throw HttpException.fromDioError(e);
    }
  }

  @override
  Future<dynamic> post(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await dio.post<dynamic>(
        endpoint,
        data: queryParameters,
      );

      return jsonDecode(response.data as String);
    } on DioError catch (e) {
      throw HttpException.fromDioError(e);
    }
  }


  @override
  Future<dynamic> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<dynamic> put() {
    // TODO: implement put
    throw UnimplementedError();
  }
}
