import 'package:flutter/material.dart';

abstract class UIColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  /// Primary
  static const Color primary = Color(0xff143d8f);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF9C4DCC);
  static const Color onPrimaryContainer = Color(0xFF4A0072);
  static const Color primaryFixed = Color(0xFF4A0072);
  static const Color primaryFixedDim = Color(0xFF6A1B9A);
  static const Color onPrimaryFixed = Color(0xFFFFFFFF);
  static const Color onPrimaryFixedVariant = Color(0xFF9C4DCC);

  /// Secondary
  static const Color secondary = Color(0xFF202124);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF4FB3BF);
  static const Color onSecondaryContainer = Color(0xFF004D40);
  static const Color secondaryFixed = Color(0xFF004D40);
  static const Color secondaryFixedDim = Color(0xFF00838F);
  static const Color onSecondaryFixed = Color(0xFFFFFFFF);
  static const Color onSecondaryFixedVariant = Color(0xFF4FB3BF);

  /// Tertiary
  static const Color tertiary = Color(0xFFD32F2F); // Red
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFE57373);
  static const Color onTertiaryContainer = Color(0xFFB71C1C);
  static const Color tertiaryFixed = Color(0xFFB71C1C);
  static const Color tertiaryFixedDim = Color(0xFFD32F2F);
  static const Color onTertiaryFixed = Color(0xFFFFFFFF);
  static const Color onTertiaryFixedVariant = Color(0xFFE57373);

  /// Error
  static const Color error = Color(0xFFD32F2F); // Red
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFE57373);
  static const Color onErrorContainer = Color(0xFFB71C1C);

  // Surface
  static const Color surfaceDim = Color(0xFF2C2C2C);
  static const Color surface = Color(0xFF121212);
  static const Color surfaceBright = Color(0xFF3D3D3D);

  /// Surface Container
  static const Color surfaceContainerLowest = Color(0xFF121212);
  static const Color surfaceContainerLow = Color(0xFF1D1D1D);
  static const Color surfaceContainer = Color(0xFF242424);
  static const Color surfaceContainerHigh = Color(0xFF2D2D2D);
  static const Color surfaceContainerHighest = Color(0xFF373737);

  /// On Surface
  static const Color onSurface = Color(0xFFE0E0E0);
  static const Color onSurfaceVariant = Color(0xFFBDBDBD);

  /// Outline
  static const Color outline = Color(0xFFB0BEC5);
  static const Color outlineVariant = Color(0xFF90A4AE);

  /// Inverse
  static const Color inverseSurface = Color(0xFF212121);
  static const Color onInverseSurface = Color(0xFFFFFFFF);
  static const Color inversePrimary = Color(0xFFCE93D8);

  /// Scrim
  static const Color scrim = Color(0xFF000000);

  /// Shadow
  static const Color shadow = Color(0xFF000000);

  /// Custom - App
  static const Color info = Color(0xFF2196F3);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color danger = Color(0xFFF44336);
}
