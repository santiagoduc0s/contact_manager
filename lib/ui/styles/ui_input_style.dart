import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';

class UIInputStyle {
  static InputDecoration defaultStyle = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UISpacing.space3x),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.deepPurple),
      borderRadius: BorderRadius.circular(UISpacing.space3x),
    ),
  );
}
