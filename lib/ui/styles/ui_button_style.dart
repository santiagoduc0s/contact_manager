import 'package:flutter/material.dart';
import 'package:contacts_manager/ui/ui.dart';

class UIButtonStyle {
  static ButtonStyle primaryFilled = ButtonStyle(
    minimumSize: WidgetStateProperty.all(
      const Size(UISpacing.zero, UISpacing.space12x),
    ),
    padding: WidgetStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(
        horizontal: UISpacing.space4x,
      ),
    ),
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.deepPurple.shade200;
        }
        if (states.contains(WidgetState.pressed)) {
          return Colors.deepPurple.shade200;
        }
        if (states.contains(WidgetState.hovered)) {
          return Colors.deepPurple.shade200;
        }
        return Colors.deepPurple.shade200;
      },
    ),
    foregroundColor: WidgetStateProperty.all(UIColors.white),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UISpacing.space2x),
      ),
    ),
    textStyle: WidgetStateProperty.all<TextStyle>(
      UITextStyle.titleMedium.copyWith(
        fontWeight: UIFontWeight.bold,
        color: UIColors.white,
      ),
    ),
  );
}
