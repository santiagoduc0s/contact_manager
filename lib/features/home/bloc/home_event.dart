import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

class InitHome extends HomeEvent {
  const InitHome();
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
