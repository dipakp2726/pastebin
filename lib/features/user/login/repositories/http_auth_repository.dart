
import 'package:pastebin/core/services/http/http_service.dart';
import 'package:pastebin/features/user/login/repositories/auth_repository.dart';

class HttpAuthRepository implements AuthRepository {
  HttpAuthRepository(this.httpService);

  /// Http service used to access an Http client and make calls
  final HttpService httpService;

  @override
  String get path => '';

  @override
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    final param = {'mobile': phone};

    final res = await httpService.post(
      'sendotp.php',
      queryParameters: param,
    );

    return res as Map<String, dynamic>;
  }

  @override
  Future<(String jwt, bool profileExist)> verifyOtp({
    required String requestId,
    required String code,
  }) async {
    final param = {
      'request_id': requestId,
      'code': code,
    };

    final res = (await httpService.post(
      'verifyotp.php',
      queryParameters: param,
    )) as Map<String, dynamic>;

    if (res['status'] as bool) {
      return (res['jwt'] as String, res['profile_exists'] as bool);
    } else {
      throw res['response'] as String;
    }
  }
}
