import 'package:flutter_riverpod/flutter_riverpod.dart';

/// provides otp textfield value
final otpProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});
