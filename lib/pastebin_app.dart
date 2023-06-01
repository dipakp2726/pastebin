import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Main App Widget
class PetsApp extends StatelessWidget {
  /// Creates new instance of [PetsApp]
  const PetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PasteBinApp',
      debugShowCheckedModeBanner: false,
      theme: const AppTheme().themeData,
      home: Container(),
    );
  }
}
