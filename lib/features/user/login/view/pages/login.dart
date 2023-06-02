import 'package:flutter/material.dart';
import 'package:pastebin/features/user/login/view/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (_) => const LoginPage(),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: LoginForm(),
      ),
    );
  }
}
