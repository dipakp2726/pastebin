import 'package:pastebin/core/services/http/http_service_provider.dart';
import 'package:pastebin/features/user/login/repositories/http_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final httpService = ref.watch(httpServiceProvider);

  return HttpAuthRepository(httpService);
}

/// Auth repository interface
abstract class AuthRepository {
  String get path;

  /// login with mobile
  ///
  Future<dynamic> sendOtp(
    String phone,
  );

  /// Verify phone number
  Future<(String, bool)> verifyOtp({
    required String requestId,
    required String code,
  });


}
