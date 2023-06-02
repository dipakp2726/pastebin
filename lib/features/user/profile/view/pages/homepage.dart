import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// The static route for [HomePage]
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('HomePage'),
        ),
      ),
    );
  }
}
