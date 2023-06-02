import 'dart:developer';

import 'package:dio/dio.dart';

/// Custom exception used with Http requests
class HttpException implements Exception {
  /// Creates a new instance of [HttpException]
  HttpException({
    this.title,
    required this.message,
    this.statusCode,
  });

  factory HttpException.fromDioError(DioError dioError) {
    String errorMessage;

    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioErrorType.connectTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioErrorType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioErrorType.response:
        errorMessage = _handleErrorResponse(dioError.response);
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errorMessage = 'No Internet.';
          break;
        }
        errorMessage = 'Unexpected error occurred.';
        break;
    }

    return HttpException(
      title: 'Http Error!',
      message: errorMessage,
      statusCode: dioError.response?.statusCode,
    );
  }

  @override
  String toString() {
    return message;
  }

  /// Exception title
  final String? title;

  /// Exception message
  final String message;

  /// Exception http response code
  final int? statusCode;

  static String _handleErrorResponse(Response<dynamic>? response) {
    if (response != null) {
      final hashMap = response.data as Map<String, dynamic>;

      log('${hashMap['message']}');
      final error = hashMap['message'] as String;

      return error;
    }

    return 'Server Responded with null';
  }
}
