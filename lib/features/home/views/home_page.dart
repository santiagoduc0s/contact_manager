import 'package:contacts_manager/features/create_contact/views/create_contact_screen.dart';
import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:contacts_manager/features/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = context.select((HomeBloc bloc) => bloc.state.contacts);

    final permissionGranted =
        context.select((HomeBloc bloc) => bloc.state.permissionGranted);

    final isFetchingContacts =
        context.select((HomeBloc bloc) => bloc.state.isFetchingContacts);

    final selectedContacts =
        context.select((HomeBloc bloc) => bloc.state.selectedContacts);

    final isSelectingContacts =
        context.select((HomeBloc bloc) => bloc.state.isSelectingContacts);

    Widget widget;

    if (!permissionGranted && !isFetchingContacts) {
      widget = const RequestContactPermission();
    } else if (isFetchingContacts) {
      widget = const Center(child: CircularProgressIndicator());
    } else if (contacts.isEmpty) {
      widget = const Center(
        child: Text('No contacts found.'),
      );
    } else {
      widget = const Stack(
        children: [
          ContactList(),
          SafeArea(
            child: Align(
              alignment: Alignment.centerRight,
              child: SliderAlphabet(),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        title: const Text('Contacts'),
        actions: [
          if (isSelectingContacts && selectedContacts.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline_outlined),
              onPressed: () {
                context.read<HomeBloc>().add(const DeleteSelectedContacts());
              },
            ),
          IconButton(
            icon: isSelectingContacts
                ? const Icon(Icons.close_outlined)
                : const Icon(Icons.select_all),
            onPressed: () {
              context.read<HomeBloc>().add(const ToggleIsSelectingContacts());
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: (Widget child, Animation<double> animation) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
        child: widget,
      ),
      floatingActionButton: permissionGranted && !isSelectingContacts
          ? FloatingActionButton(
              heroTag: 'goToCreateContactPage',
              onPressed: () {
                context.pushNamed(CreateContactScreen.path);
              },
              tooltip: 'Go to Create Contact Page',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
