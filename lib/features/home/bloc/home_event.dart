import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

class HomeInit extends HomeEvent {
  const HomeInit();
}

class HomeListen extends HomeEvent {
  const HomeListen();
}

class FetchContacts extends HomeEvent {
  const FetchContacts();
}

class ToggleIsSelectingContacts extends HomeEvent {
  const ToggleIsSelectingContacts();
}

class SelectContact extends HomeEvent {
  const SelectContact(this.contact);

  final Contact contact;
}

class DeleteSelectedContacts extends HomeEvent {
  const DeleteSelectedContacts();
}

class ChangeSelectedLetterIndex extends HomeEvent {
  const ChangeSelectedLetterIndex(this.index);

  final int index;
}

class AddContactHome extends HomeEvent {
  const AddContactHome(this.contact);

  final Contact contact;
}

class UpdateContactHome extends HomeEvent {
  const UpdateContactHome(this.contact);

  final Contact contact;
}
