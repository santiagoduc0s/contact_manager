import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

class HomeInit extends HomeEvent {
  const HomeInit();
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
