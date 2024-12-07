import 'package:flutter/material.dart';

abstract class UIColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  /// Primary
  static const MaterialColor primary = MaterialColor(0xff143d8f, <int, Color>{
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFDFCFF),
    95: Color(0xFFF8F9FF),
    90: Color(0xFFD1E4FF),
    80: Color(0xFF9DCAFF),
    70: Color(0xFF80AFE4),
    60: Color(0xFF6594C7),
    50: Color(0xFF4A7AAC),
    40: Color(0xFF2F6192),
    30: Color(0xFF205585),
    20: Color(0xFF003257),
    10: Color(0xFF001D35),
    0: Color(0xFF000000),
  });

  /// Secondary
  static const MaterialColor secondary = MaterialColor(0xFF202124, <int, Color>{
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFDFCFF),
    95: Color(0xFFF8F9FF),
    90: Color(0xFFD1E4FF),
    80: Color(0xFF9DCAFF),
    70: Color(0xFF80AFE4),
    60: Color(0xFF6594C7),
    50: Color(0xFF4A7AAC),
    40: Color(0xFF2F6192),
    30: Color(0xFF205585),
    20: Color(0xFF003257),
    10: Color(0xFF001D35),
    0: Color(0xFF000000),
  });

  /// Tertiary
  static const MaterialColor tertiary = MaterialColor(0xFFD32F2F, <int, Color>{
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFDFCFF),
    95: Color(0xFFF8F9FF),
    90: Color(0xFFD1E4FF),
    80: Color(0xFF9DCAFF),
    70: Color(0xFF80AFE4),
    60: Color(0xFF6594C7),
    50: Color(0xFF4A7AAC),
    40: Color(0xFF2F6192),
    30: Color(0xFF205585),
    20: Color(0xFF003257),
    10: Color(0xFF001D35),
    0: Color(0xFF000000),
  });

  /// Success
  static const MaterialColor success = MaterialColor(0xFF4CAF50, <int, Color>{
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFDFCFF),
    95: Color(0xFFF8F9FF),
    90: Color(0xFFD1E4FF),
    80: Color(0xFF9DCAFF),
    70: Color(0xFF80AFE4),
    60: Color(0xFF6594C7),
    50: Color(0xFF4A7AAC),
    40: Color(0xFF2F6192),
    30: Color(0xFF205585),
    20: Color(0xFF003257),
    10: Color(0xFF001D35),
    0: Color(0xFF000000),
  });

  /// Error
  static const MaterialColor error = MaterialColor(0xFFD32F2F, <int, Color>{
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFDFCFF),
    95: Color(0xFFF8F9FF),
    90: Color(0xFFD1E4FF),
    80: Color(0xFF9DCAFF),
    70: Color(0xFF80AFE4),
    60: Color(0xFF6594C7),
    50: Color(0xFF4A7AAC),
    40: Color(0xFF2F6192),
    30: Color(0xFF205585),
    20: Color(0xFF003257),
    10: Color(0xFF001D35),
    0: Color(0xFF000000),
  });

  // Neutral
  static const MaterialColor neutral = MaterialColor(0xFFF5F1ED, <int, Color>{
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFDFCFF),
    95: Color(0xFFF8F9FF),
    90: Color(0xFFD1E4FF),
    80: Color(0xFF9DCAFF),
    70: Color(0xFF80AFE4),
    60: Color(0xFF6594C7),
    50: Color(0xFF4A7AAC),
    40: Color(0xFF2F6192),
    30: Color(0xFF205585),
    20: Color(0xFF003257),
    10: Color(0xFF001D35),
    0: Color(0xFF000000),
  });

  // Neutral Variant
  static const MaterialColor neutralVariant =
      MaterialColor(0xFFF1EAE5, <int, Color>{
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFDFCFF),
    95: Color(0xFFF8F9FF),
    90: Color(0xFFD1E4FF),
    80: Color(0xFF9DCAFF),
    70: Color(0xFF80AFE4),
    60: Color(0xFF6594C7),
    50: Color(0xFF4A7AAC),
    40: Color(0xFF2F6192),
    30: Color(0xFF205585),
    20: Color(0xFF003257),
    10: Color(0xFF001D35),
    0: Color(0xFF000000),
  });

  /// Custom - App
  static const Color info = Color(0xFF2196F3);
  static const Color warning = Color(0xFFFF9800);
}
