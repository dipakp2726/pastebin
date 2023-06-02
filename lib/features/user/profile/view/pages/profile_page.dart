import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  /// The static route for [ProfilePage]
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
      ),
      body: const SafeArea(
        child: SizedBox(),
      ),
    );
  }
}
