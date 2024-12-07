import 'package:contacts_manager/features/create_contact/views/create_contact_screen.dart';
import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:contacts_manager/features/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  @override
  Widget build(BuildContext context) {
    context.select((HomeBloc bloc) => bloc.state.contacts);

    bool permissionGranted =
        context.select((HomeBloc bloc) => bloc.state.permissionGranted);

    bool isFetchingContacts =
        context.select((HomeBloc bloc) => bloc.state.isFetchingContacts);

    bool isRequestingPermission =
        context.select((HomeBloc bloc) => bloc.state.isRequestingPermission);

    bool isSelectingContacts =
        context.select((HomeBloc bloc) => bloc.state.isSelectingContacts);

    bool keyboardVisible = isKeyboardVisible(context);

    Widget widget;

    if (isFetchingContacts || isRequestingPermission) {
      widget = const Center(child: CircularProgressIndicator());
    } else if (!permissionGranted) {
      widget = const RequestContactPermission();
    } else {
      widget = Stack(
        children: [
          const ContactList(),
          SafeArea(
            child: Align(
              alignment: Alignment.centerRight,
              child: FadeInRight(
                animate: !keyboardVisible,
                duration: const Duration(milliseconds: 300),
                child: const SliderAlphabet(),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: const AppBarHome(),
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
      floatingActionButton:
          permissionGranted && !isSelectingContacts && !keyboardVisible
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
