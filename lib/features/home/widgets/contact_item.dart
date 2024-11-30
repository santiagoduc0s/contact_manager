import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.keyDivider,
    required this.showDivider,
    required this.firstLetterOfName,
    required this.isSelected,
    required this.contact,
    required this.isSelectingContacts,
  });

  final GlobalKey? keyDivider;
  final bool showDivider;
  final String firstLetterOfName;
  final bool isSelected;
  final Contact contact;
  final bool isSelectingContacts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDivider)
          Padding(
            key: keyDivider,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Text(
              firstLetterOfName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ListTile(
          tileColor: isSelected ? Colors.deepPurple.withOpacity(0.2) : null,
          leading: contact.photo != null
              ? CircleAvatar(backgroundImage: MemoryImage(contact.photo!))
              : const CircleAvatar(child: Icon(Icons.person)),
          title: Text(
            '${contact.name.first} ${contact.name.last}',
            style:
                isSelected ? const TextStyle(color: Colors.deepPurple) : null,
          ),
          subtitle: Text(
            contact.phones.isNotEmpty
                ? contact.phones.first.number
                : 'No phone number',
            style:
                isSelected ? const TextStyle(color: Colors.deepPurple) : null,
          ),
          onTap: isSelectingContacts
              ? () {
                  context.read<HomeBloc>().add(SelectContact(contact));
                }
              : () async {
                  // final editedContact =
                  //     await Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         EditContactScreen(contact: contact),
                  //   ),
                  // );

                  // if (editedContact != null &&
                  //     editedContact is Contact) {
                  //   setState(() {
                  //     contacts[index] = editedContact;
                  //   });
                  // }
                },
        ),
      ],
    );
  }
}
