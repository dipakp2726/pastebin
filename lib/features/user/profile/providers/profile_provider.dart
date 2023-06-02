import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pastebin/features/user/profile/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

final nameProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final emailProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

@riverpod
FutureOr<dynamic> profileSubmit(
  ProfileSubmitRef ref, {
  required String name,
  required String email,
}) async {
  final repo = ref.watch(userRepositoryProvider);

  final res = await repo.profileSubmit(name, email);

  return res;
}
