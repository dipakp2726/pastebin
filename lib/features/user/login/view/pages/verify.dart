import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pastebin/features/user/login/providers/providers.dart';
import 'package:pastebin/features/user/login/view/widgets/widgets.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  static Route<void> route({required String phoneNumber}) =>
      MaterialPageRoute<void>(
        builder: (_) => ProviderScope(
          overrides: [
            phoneRequestIdProvider.overrideWithValue(phoneNumber),
          ],
          child: const VerifyPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: VerifyForm(),
      ),
    );
  }
}
