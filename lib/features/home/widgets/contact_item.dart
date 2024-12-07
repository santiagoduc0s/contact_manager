import 'package:contacts_manager/features/edit_contact/views/edit_contact_screen.dart';
import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
              horizontal: UISpacing.space4x,
              vertical: UISpacing.space3x,
            ),
            child: Text(
              firstLetterOfName,
              style: UITextStyle.titleMedium,
            ),
          ),
        ListTile(
          tileColor: isSelected ? Colors.deepPurple.withOpacity(0.2) : null,
          leading: Hero(
            tag: contact.id,
            child: contact.photo != null
                ? CircleAvatar(
                    radius: UISpacing.space5x,
                    backgroundImage: MemoryImage(contact.photo!),
                  )
                : const CircleAvatar(
                    radius: UISpacing.space5x,
                    child: Icon(Icons.person, size: UISpacing.space6x),
                  ),
          ),
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
              ? () => context.read<HomeBloc>().add(SelectContact(contact))
              : () => context.pushNamed(EditContactScreen.path, extra: contact),
        ),
      ],
    );
  }
}
