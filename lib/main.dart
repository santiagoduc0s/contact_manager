import 'package:contacts_manager/config/config.dart';
import 'package:contacts_manager/router/router.dart';
import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: UITheme.standard,
      routerConfig: AppRouter.router,
    );
  }
}
