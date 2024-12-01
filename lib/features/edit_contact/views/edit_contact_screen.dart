import 'package:contacts_manager/features/edit_contact/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';

class EditContactScreen extends StatelessWidget {
  const EditContactScreen({super.key});

  static const path = '/edit-contact';

  static GoRoute route({
    List<RouteBase> routes = const [],
    GlobalKey<NavigatorState>? parentNavigatorKey,
  }) =>
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: path,
        name: path,
        builder: (context, state) {
          final contact = state.extra as Contact;

          return EditContactPage(contact: contact);
        },
        routes: routes,
      );

  @override
  Widget build(BuildContext context) {
    return const EditContactScreen();
  }
}
