import 'package:contacts_manager/config/app_keys.dart';
import 'package:flutter/material.dart';

class SnackbarActions {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) {
    hideSnackBar();

    final currentState = AppKeys.scaffoldMessengerKey.currentState;

    return currentState!.showSnackBar(snackBar);
  }

  static void hideSnackBar() {
    final currentState = AppKeys.scaffoldMessengerKey.currentState;

    if (currentState == null) return;

    currentState.hideCurrentSnackBar();
  }
}
