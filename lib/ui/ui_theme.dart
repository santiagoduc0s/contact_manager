import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';

class UITheme {
  static ThemeData get standard {
    return ThemeData(
      iconTheme: iconTheme,
      appBarTheme: appBarTheme,
      scaffoldBackgroundColor: UIColors.white,
      dialogBackgroundColor: UIColors.white,
      canvasColor: UIColors.white,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      textTheme: textTheme,
    );
  }

  static AppBarTheme get appBarTheme {
    return const AppBarTheme(
      backgroundColor: UIColors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
    );
  }

  static IconThemeData get iconTheme {
    return const IconThemeData(
      color: UIColors.black,
    );
  }

  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: UITextStyle.displayLarge,
      displayMedium: UITextStyle.displayMedium,
      displaySmall: UITextStyle.displaySmall,
      headlineLarge: UITextStyle.headlineLarge,
      headlineMedium: UITextStyle.headlineMedium,
      headlineSmall: UITextStyle.headlineSmall,
      titleLarge: UITextStyle.titleLarge,
      titleMedium: UITextStyle.titleMedium,
      titleSmall: UITextStyle.titleSmall,
      bodyLarge: UITextStyle.bodyLarge,
      bodyMedium: UITextStyle.bodyMedium,
      bodySmall: UITextStyle.bodySmall,
      labelLarge: UITextStyle.labelLarge,
      labelMedium: UITextStyle.labelMedium,
      labelSmall: UITextStyle.labelSmall,
    );
  }

  static ColorScheme get colorScheme {
    return const ColorScheme(
      brightness: Brightness.light,

      /// Primary
      primary: UIColors.primary,
      onPrimary: UIColors.onPrimary,
      primaryContainer: UIColors.primaryContainer,
      onPrimaryContainer: UIColors.onPrimaryContainer,
      primaryFixed: UIColors.primaryFixed,
      primaryFixedDim: UIColors.primaryFixedDim,
      onPrimaryFixed: UIColors.onPrimaryFixed,
      onPrimaryFixedVariant: UIColors.onPrimaryFixedVariant,

      /// Secondary
      secondary: UIColors.secondary,
      onSecondary: UIColors.onSecondary,
      secondaryContainer: UIColors.secondaryContainer,
      onSecondaryContainer: UIColors.onSecondaryContainer,
      secondaryFixed: UIColors.secondaryFixed,
      secondaryFixedDim: UIColors.secondaryFixedDim,
      onSecondaryFixed: UIColors.onSecondaryFixed,
      onSecondaryFixedVariant: UIColors.onSecondaryFixedVariant,

      /// Tertiary
      tertiary: UIColors.tertiary,
      onTertiary: UIColors.onTertiary,
      tertiaryContainer: UIColors.tertiaryContainer,
      onTertiaryContainer: UIColors.onTertiaryContainer,
      tertiaryFixed: UIColors.tertiaryFixed,
      tertiaryFixedDim: UIColors.tertiaryFixedDim,
      onTertiaryFixed: UIColors.onTertiaryFixed,
      onTertiaryFixedVariant: UIColors.onTertiaryFixedVariant,

      /// Error
      error: UIColors.error,
      onError: UIColors.onError,
      errorContainer: UIColors.errorContainer,
      onErrorContainer: UIColors.onErrorContainer,

      // Surface
      surfaceDim: UIColors.surfaceDim,
      surface: UIColors.surface,
      surfaceBright: UIColors.surfaceBright,

      /// Surface Container
      surfaceContainerLowest: UIColors.surfaceContainerLowest,
      surfaceContainerLow: UIColors.surfaceContainerLow,
      surfaceContainer: UIColors.surfaceContainer,
      surfaceContainerHigh: UIColors.surfaceContainerHigh,
      surfaceContainerHighest: UIColors.surfaceContainerHighest,

      /// On Surface
      onSurface: UIColors.onSurface,
      onSurfaceVariant: UIColors.onSurfaceVariant,

      /// Outline
      outline: UIColors.outline,
      outlineVariant: UIColors.outlineVariant,

      /// Inverse
      inverseSurface: UIColors.inverseSurface,
      onInverseSurface: UIColors.onInverseSurface,
      inversePrimary: UIColors.inversePrimary,

      /// Scrim
      scrim: UIColors.scrim,

      /// Shadow
      shadow: UIColors.shadow,
    );
  }
}
