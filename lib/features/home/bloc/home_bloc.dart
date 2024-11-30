import 'package:contacts_manager/features/home/bloc/home_event.dart';
import 'package:contacts_manager/features/home/bloc/home_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> with WidgetsBindingObserver {
  HomeBloc({
    ScrollController? scrollController,
  })  : scrollController = scrollController ?? ScrollController(),
        super(const HomeState.initial()) {
    on<HomeInit>(_onInitHome);
    on<FetchContacts>(_onFetchContacts);
    on<ToggleIsSelectingContacts>(_onToggleIsSelectingContacts);
    on<SelectContact>(_onSelectContact);
    on<DeleteSelectedContacts>(_onDeleteSelectedContacts);
    on<ChangeSelectedLetterIndex>(_onChangeSelectedLetterIndex);

    WidgetsBinding.instance.addObserver(this);
  }

  final ScrollController scrollController;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      add(const HomeInit());
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  void _onInitHome(HomeInit event, Emitter<HomeState> emit) async {
    bool granted = await FlutterContacts.requestPermission();
    emit(state.copyWith(permissionGranted: granted));

    if (granted) {
      add(const FetchContacts());
    }
  }

  Future<void> _onFetchContacts(
    FetchContacts event,
    Emitter<HomeState> emit,
  ) async {
    if (state.isFetchingContacts) return;

    emit(state.copyWith(isFetchingContacts: true));

    await Future.delayed(const Duration(seconds: 2));

    try {
      List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );

      contacts = contacts.map((contact) {
        if (contact.displayName.isEmpty) {
          return contact
            ..displayName = 'Unnamed Contact'
            ..name = Name(
              first: 'Unnamed',
              last: 'Contact',
            );
        }
        return contact;
      }).toList();

      contacts.sort((a, b) {
        final nameA = a.displayName.toLowerCase();
        final nameB = b.displayName.toLowerCase();
        return nameA.compareTo(nameB);
      });

      final firstLetters = <String>{};

      for (Contact contact in contacts) {
        firstLetters.add(contact.displayName[0].toUpperCase());
      }

      final keyValues = <String, GlobalKey>{};

      for (String letter in firstLetters) {
        keyValues[letter] = GlobalKey();
      }

      emit(state.copyWith(
        contacts: contacts,
        initialLetters: firstLetters.toList(),
        keys: keyValues,
      ));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      emit(state.copyWith(isFetchingContacts: false));
    }
  }

  void _onToggleIsSelectingContacts(
    ToggleIsSelectingContacts event,
    Emitter<HomeState> emit,
  ) {
    final newValue = !state.isSelectingContacts;

    if (newValue) {
      emit(state.copyWith(isSelectingContacts: !state.isSelectingContacts));
    } else {
      emit(state.copyWith(
        selectedContacts: {},
        isSelectingContacts: newValue,
      ));
    }
  }

  Future<void> _onSelectContact(
    SelectContact event,
    Emitter<HomeState> emit,
  ) async {
    final newSelectedContacts = {...state.selectedContacts};

    if (newSelectedContacts.contains(event.contact)) {
      newSelectedContacts.remove(event.contact);
    } else {
      newSelectedContacts.add(event.contact);
    }

    emit(state.copyWith(selectedContacts: newSelectedContacts));
  }

  void _onDeleteSelectedContacts(
    DeleteSelectedContacts event,
    Emitter<HomeState> emit,
  ) async {
    final futures = <Future>[];
    for (Contact contact in state.selectedContacts) {
      futures.add(contact.delete());
    }

    await Future.wait(futures);

    final newContacts = state.contacts.where((contact) {
      return !state.selectedContacts.contains(contact);
    }).toList();

    emit(state.copyWith(
      contacts: newContacts,
      selectedContacts: {},
      isSelectingContacts: false,
    ));
  }

  void _onChangeSelectedLetterIndex(
    ChangeSelectedLetterIndex event,
    Emitter<HomeState> emit,
  ) {
    if (event.index == state.selectedLetterIndex) return;

    HapticFeedback.selectionClick();

    emit(state.copyWith(selectedLetterIndex: event.index));

    final letter = state.initialLetters[event.index];

    final context = state.keys[letter]?.currentContext;

    if (context == null) return;

    Scrollable.ensureVisible(context, alignment: 0);
  }
}
