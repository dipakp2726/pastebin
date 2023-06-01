import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// {@template app_back_button}
///  Alert IconButton displayed in the application.
/// {@endtemplate}
class AlertIconButton extends StatelessWidget {
  /// Creates a default instance of [AlertIconButton].
  const AlertIconButton({
    super.key,
    this.onPressed,
  });

  /// button tap callback
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Badge(
        child: Icon(
          CupertinoIcons.bell,
          size: 28,
          color: AppColors.white,
        ),
      ),
    );
  }
}
