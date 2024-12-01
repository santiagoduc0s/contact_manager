import 'package:flutter/material.dart';

class AppKeys {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static BuildContext getRootContext() {
    return rootNavigatorKey.currentContext!;
  }
}
