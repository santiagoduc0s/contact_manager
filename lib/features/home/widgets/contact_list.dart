import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:contacts_manager/features/home/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final contacts = context.select((HomeBloc bloc) => bloc.state.contacts);

    final selectedContacts =
        context.select((HomeBloc bloc) => bloc.state.selectedContacts);

    final isSelectingContacts =
        context.select((HomeBloc bloc) => bloc.state.isSelectingContacts);

    final keyValues = context.select((HomeBloc bloc) => bloc.state.keys);

    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(contacts.length, (index) {
          Contact contact = contacts[index];
          bool isSelected = selectedContacts.contains(contact);

          String displayName = contact.displayName;
          String firstLetterOfName = displayName.trim()[0].toUpperCase();
          String firstLetterOfThePreviousName = index == 0
              ? ''
              : contacts[index - 1].displayName.trim()[0].toUpperCase();

          bool showDivider =
              index == 0 || firstLetterOfName != firstLetterOfThePreviousName;

          final key = keyValues[firstLetterOfName];

          return ContactItem(
            keyDivider: key,
            showDivider: showDivider,
            firstLetterOfName: firstLetterOfName,
            isSelected: isSelected,
            contact: contact,
            isSelectingContacts: isSelectingContacts,
          );
        }),
      ),
    );
  }
}
