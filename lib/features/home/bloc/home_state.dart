import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter/material.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.initialLetters,
    required this.contacts,
    required this.isFetchingContacts,
    required this.permissionGranted,
    required this.selectedContacts,
    required this.isSelectingContacts,
    required this.selectedLetterIndex,
    required this.keys,
  });

  const HomeState.initial({
    this.initialLetters = const [],
    this.contacts = const [],
    this.isFetchingContacts = false,
    this.permissionGranted = false,
    this.selectedContacts = const {},
    this.isSelectingContacts = false,
    this.selectedLetterIndex = 0,
    this.keys = const {},
  });

  final List<String> initialLetters;
  final List<Contact> contacts;
  final bool isFetchingContacts;
  final bool permissionGranted;
  final Set<Contact> selectedContacts;
  final bool isSelectingContacts;
  final int selectedLetterIndex;
  final Map<String, GlobalKey> keys;

  HomeState copyWith({
    List<String>? initialLetters,
    List<Contact>? contacts,
    bool? isFetchingContacts,
    bool? permissionGranted,
    Set<Contact>? selectedContacts,
    bool? isSelectingContacts,
    int? selectedLetterIndex,
    Map<String, GlobalKey>? keys,
  }) {
    return HomeState(
      initialLetters: initialLetters ?? this.initialLetters,
      contacts: contacts ?? this.contacts,
      isFetchingContacts: isFetchingContacts ?? this.isFetchingContacts,
      permissionGranted: permissionGranted ?? this.permissionGranted,
      selectedContacts: selectedContacts ?? this.selectedContacts,
      isSelectingContacts: isSelectingContacts ?? this.isSelectingContacts,
      selectedLetterIndex: selectedLetterIndex ?? this.selectedLetterIndex,
      keys: keys ?? this.keys,
    );
  }

  @override
  List<Object> get props => [
        initialLetters,
        contacts,
        isFetchingContacts,
        permissionGranted,
        selectedContacts,
        isSelectingContacts,
        selectedLetterIndex,
        keys,
      ];
}
