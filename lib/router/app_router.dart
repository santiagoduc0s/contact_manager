import 'package:contacts_manager/config/config.dart';
import 'package:contacts_manager/features/home/home.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: AppKeys.rootNavigatorKey,
    initialLocation: HomeScreen.path,
    routes: [
      HomeScreen.route(),
    ],
  );
}
