import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:pastebin/features/user/login/view/pages/login.dart';

/// Main App Widget
class PasteBinApp extends StatelessWidget {
  /// Creates new instance of [PasteBinApp]
  const PasteBinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PasteBinApp',
      debugShowCheckedModeBanner: false,
      theme: const AppTheme().themeData,
      home: const LoginPage(),
    );
  }
}
