// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

/// Defines the color palette for the App UI Kit.
abstract class AppColors {
  /// Black
  static const Color black = Color(0xFF000000);

  /// Light black
  static const Color lightBlack = Colors.black54;

  /// White
  static const Color white = Color(0xFFFFFFFF);

  /// Transparent
  static const Color transparent = Color(0x00000000);

  /// The green Color
  static const Color green = Color(0xFF28A745);

  /// The grey color.
  static const Color grey = Color(0xFF7F818B);

  /// The dark grey color.
  static const Color darkGrey = Color(0xFF707070);

  /// The dark blue color.
  static const Color secondary = Color(0xFF171336);

  /// The light blue-grey color.
  static const Color lightBlueGrey = Color(0xFFF4F8FD);

  /// The border outline color.
  static const Color borderOutline = Color(0x33000000);

  /// The light outline color.
  static const Color outlineLight = Color(0x33000000);

  /// The outline on dark color.
  static const Color outlineOnDark = Color(0x29FFFFFF);

  /// The dark blue color.
  static const Color darkBlue = Color(0xFF171336);

  /// The dark blue color.
  static const Color yellow = Color(0xFFE5A701);

  /// The default disabled foreground color.
  static const Color disabledForeground = Color(0x611B1B1B);

  /// The default disabled button color.
  static const Color disabledButton = Color(0x1F000000);

  /// The default disabled surface color.
  static const Color disabledSurface = Color(0xFFE0E0E0);

  /// The on-background color.
  static const Color onBackground = Color(0xFF1A1A1A);

  /// The dark aqua color.
  static const Color darkAqua = Color(0xFF00677F);

  /// The lavender Pink color.
  static const Color lavenderPink = Color(0xFFEFECFB);

  /// The lavender grey color.
  static const Color lavenderGrey = Color(0xFFD0CFD6);

  /// The light grey font  color.
  static const Color fontGrey = Color(0xFFADABB8);

  /// The light yellow color.
  static const Color lightYellow = Color(0xFFFFEEBA);

  /// The light yellow color.
  static const Color lightYellowFont = Color(0xFF856404);

  /// The Danger light color.
  static const Color dangerLight = Color(0xFFF8D7DA);

  /// The Danger light color.
  static const Color dangerFont = Color(0xFF721C24);

  /// The Error color.
  static const Color errorColor = Color(0xFFF71917);

  /// Returns a shade of a [Color] from a double value
  ///
  /// The 'darker' boolean determines whether the shade
  /// should be .1 darker or lighter than the provided color
  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1, 'shade values must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
      (darker ? (hsl.lightness - value) : (hsl.lightness + value))
          .clamp(0.0, 1.0),
    );

    return hslDark.toColor();
  }

  /// Returns a [MaterialColor] from a [Color] object
  static MaterialColor getMaterialColorFromColor(Color color) {
    final colorShades = <int, Color>{
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}
