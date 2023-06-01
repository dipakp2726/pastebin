import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// {@template app_back_button}
/// IconButton displayed in the application.
/// Navigates back when is pressed.
/// {@endtemplate}

class AppBackButton extends StatelessWidget {
  /// Creates a default instance of [AppBackButton].
  const AppBackButton({
    Key? key,
    VoidCallback? onPressed,
  }) : this._(
          key: key,
          isLight: false,
          onPressed: onPressed,
        );

  /// Creates a light instance of [AppBackButton].
  const AppBackButton.light({
    Key? key,
    VoidCallback? onPressed,
  }) : this._(
          key: key,
          isLight: true,
          onPressed: onPressed,
        );

  /// {@macro app_back_button}
  const AppBackButton._({required this.isLight, this.onPressed, super.key});

  /// Whether this app button is light.
  final bool isLight;

  /// Called when the back button has been tapped.
  /// Defaults to `Navigator.of(context).pop()`
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lavenderPink),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: IconButton(
        splashRadius: 40,
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back_ios_outlined,
          color: AppColors.black,
          size: 20,
        ),
      ),
    );
  }
}

/// {@template app_back_button}
/// IconButton displayed in the application.
/// Navigates back when is pressed.
/// {@endtemplate}
class AppBackIconButton extends StatelessWidget {
  /// Creates a default instance of [AppBackIconButton].
  const AppBackIconButton({super.key, this.onPressed});

  /// Called when the back button has been tapped.
  /// Defaults to `Navigator.of(context).pop()`
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 40,
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      icon: const Icon(
        CupertinoIcons.chevron_left,
        size: 32,
      ),
    );
  }
}
