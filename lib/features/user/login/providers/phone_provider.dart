import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pastebin/core/services/storage/storage_service_provider.dart';
import 'package:pastebin/features/user/login/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'phone_provider.g.dart';


/// phone auth controller
@riverpod
class PhoneAuth extends _$PhoneAuth {
  @override
  void build() {}

  Future<AsyncValue<dynamic>> sendOtp(String phone) async {
    final repo = ref.watch(authRepositoryProvider);

    final resp = repo.sendOtp(phone);

    return AsyncValue.guard(() async => resp);
  }

  Future<bool> verifyOtp(String requestId, String code) async {
    final repo = ref.watch(authRepositoryProvider);

    final resp = await repo.verifyOtp(
      requestId: requestId,
      code: code,
    );

    final storageService = ref.watch(storageServiceProvider);

    await storageService.set('token_key', resp.$1);

    return resp.$2;
  }

}

/// The provider that provides the phone number
///
/// Initially it throws an UnimplementedError because we won't use it
/// before overriding it
///

final phoneRequestIdProvider = Provider<String>((ref) {
  throw UnimplementedError();
});

/// phone text field value provider
final phoneProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});
