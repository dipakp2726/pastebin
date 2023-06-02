import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pastebin/core/services/http/http_service.dart';
import 'package:pastebin/core/services/http/http_service_provider.dart';

part 'iuser_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);

  return UserRepository(httpService);
});

/// {@template user_repository}
/// UserRepository description
/// {@endtemplate}
class UserRepository implements IUserRepository {
  /// {@macro user_repository}
  const UserRepository(this.httpService);

  /// Http service used to access an Http client and make calls
  final HttpService httpService;

  @override
  String get path => '';

  @override
  Future<dynamic> profileSubmit(String name, String email) async {
    final param = {'name': name, 'email': email};

    final res = await httpService.post(
      'profilesubmit.php',
      queryParameters: param,
    );

    return res;
  }
}
