import 'package:flutter/material.dart';

class AppKeys {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static BuildContext getRootContext() {
    return rootNavigatorKey.currentContext!;
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) {
    hideSnackBar();

    final currentState = scaffoldMessengerKey.currentState;

    return currentState!.showSnackBar(snackBar);
  }

  static void hideSnackBar() {
    final currentState = scaffoldMessengerKey.currentState;

    if (currentState == null) return;

    currentState.hideCurrentSnackBar();
  }
}
