import 'package:contacts_manager/features/create_contact/views/views.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateContactScreen extends StatelessWidget {
  const CreateContactScreen({super.key});

  static const path = '/create-contact';

  static GoRoute route({
    List<RouteBase> routes = const [],
    GlobalKey<NavigatorState>? parentNavigatorKey,
  }) =>
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: path,
        name: path,
        builder: (context, state) {
          return const CreateContactPage();
        },
        routes: routes,
      );

  @override
  Widget build(BuildContext context) {
    return const CreateContactScreen();
  }
}
