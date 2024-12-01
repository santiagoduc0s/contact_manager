import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';

class UIInputStyle {
  static InputDecoration defaultStyle() => InputDecoration(
        labelStyle: UITextStyle.titleMedium.copyWith(
          fontWeight: UIFontWeight.light,
          color: UIColors.secondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            UISpacing.space2x,
          ),
          borderSide: const BorderSide(
            color: UIColors.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            UISpacing.space2x,
          ),
          borderSide: const BorderSide(
            color: UIColors.secondary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            UISpacing.space2x,
          ),
          borderSide: const BorderSide(
            color: UIColors.secondary,
            width: .5,
          ),
        ),
        helperStyle: UITextStyle.labelMedium.copyWith(
          fontWeight: UIFontWeight.light,
          color: UIColors.secondary,
        ),
      );
}
