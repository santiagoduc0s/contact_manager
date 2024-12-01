import 'package:flutter/material.dart';
import 'package:contacts_manager/ui/ui.dart';

class UIButtonStyle {
  static ButtonStyle get primaryFilled => ButtonStyle(
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
              return UIColors.primary;
            }
            if (states.contains(WidgetState.pressed)) {
              return UIColors.primary;
            }
            if (states.contains(WidgetState.hovered)) {
              return UIColors.primary;
            }
            return UIColors.primary;
          },
        ),
        foregroundColor: WidgetStateProperty.all(UIColors.white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UISpacing.space10x),
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
