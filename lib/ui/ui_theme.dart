import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';

class UITheme {
  static ThemeData get standard {
    return ThemeData(
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
    return ColorScheme(
      brightness: Brightness.light,
      primary: UIColors.primary,
      onPrimary: UIColors.primary[100]!,
      secondary: UIColors.secondary,
      onSecondary: UIColors.secondary[100]!,
      tertiary: UIColors.tertiary,
      onTertiary: UIColors.tertiary[100]!,
      error: UIColors.error,
      onError: UIColors.error[100]!,
      surface: UIColors.neutral[99]!,
      onSurface: UIColors.neutral[20]!,
    );
  }
}
