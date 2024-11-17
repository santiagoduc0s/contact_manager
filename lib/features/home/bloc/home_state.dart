import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.initialLetters,
    required this.contacts,
    required this.isFetchingContacts,
    required this.permissionGranted,
    required this.selectedContacts,
    required this.isSelectingContacts,
  });

  const HomeState.initial({
    this.initialLetters = const [],
    this.contacts = const [],
    this.isFetchingContacts = false,
    this.permissionGranted = false,
    this.selectedContacts = const {},
    this.isSelectingContacts = false,
  });

  final List<String> initialLetters;
  final List<Contact> contacts;
  final bool isFetchingContacts;
  final bool permissionGranted;
  final Set<Contact> selectedContacts;
  final bool isSelectingContacts;

  HomeState copyWith({
    List<String>? initialLetters,
    List<Contact>? contacts,
    bool? isFetchingContacts,
    bool? permissionGranted,
    Set<Contact>? selectedContacts,
    bool? isSelectingContacts,
  }) {
    return HomeState(
      initialLetters: initialLetters ?? this.initialLetters,
      contacts: contacts ?? this.contacts,
      isFetchingContacts: isFetchingContacts ?? this.isFetchingContacts,
      permissionGranted: permissionGranted ?? this.permissionGranted,
      selectedContacts: selectedContacts ?? this.selectedContacts,
      isSelectingContacts: isSelectingContacts ?? this.isSelectingContacts,
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
      ];
}
