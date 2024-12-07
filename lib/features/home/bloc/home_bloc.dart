import 'dart:async';

import 'package:contacts_manager/alerts/alerts.dart';
import 'package:contacts_manager/config/app_keys.dart';
import 'package:contacts_manager/cruds/cruds.dart';
import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> with WidgetsBindingObserver {
  HomeBloc({
    ScrollController? scrollController,
  })  : scrollController = scrollController ?? ScrollController(),
        super(const HomeState.initial()) {
    on<HomeInit>(_onHomeInit);
    on<HomeListen>(_onHomeListen);
    on<FetchContacts>(_onFetchContacts);
    on<ToggleIsSelectingContacts>(_onToggleIsSelectingContacts);
    on<SelectContact>(_onSelectContact);
    on<DeleteSelectedContacts>(_onDeleteSelectedContacts);
    on<ChangeSelectedLetterIndex>(_onChangeSelectedLetterIndex);
    on<AddContactHome>(_onAddContact);
    on<UpdateContactHome>(_onUpdateContact);
    on<DeleteContactHome>(_onDeleteContact);
    on<SearchContacts>(_onSearchContacts);

    WidgetsBinding.instance.addObserver(this);
  }

  final ScrollController scrollController;

  late final StreamSubscription<Object> contactCreateSubscription;
  late final StreamSubscription<Object> contactUpdateSubscription;
  late final StreamSubscription<Object> contactDeleteSubscription;

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

    contactCreateSubscription.cancel();
    contactUpdateSubscription.cancel();
    contactDeleteSubscription.cancel();

    return super.close();
  }

  Map<String, dynamic> _processContacts(List<Contact> contacts) {
    contacts = contacts.map((contact) {
      if (contact.displayName.isEmpty) {
        return contact
          ..displayName = 'Unnamed Contact'
          ..name = Name(first: 'Unnamed', last: 'Contact');
      }
      return contact;
    }).toList();

    contacts.sort((a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));

    final firstLetters = <String>{};
    final keyValues = <String, GlobalKey>{};

    for (Contact contact in contacts) {
      final firstChar = contact.displayName[0].toUpperCase();
      if (RegExp(r'[A-Za-z]').hasMatch(firstChar)) {
        firstLetters.add(firstChar);
        keyValues[firstChar] = GlobalKey();
      }
    }

    return {
      'contacts': contacts,
      'initialLetters': firstLetters.toList(),
      'keys': keyValues,
    };
  }

  void _onHomeInit(HomeInit event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isRequestingPermission: true));

    try {
      bool granted = await FlutterContacts.requestPermission();

      emit(state.copyWith(permissionGranted: granted));

      if (granted) {
        add(const FetchContacts());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      emit(state.copyWith(isRequestingPermission: false));
    }
  }

  void _onHomeListen(HomeListen event, Emitter<HomeState> emit) {
    contactCreateSubscription =
        ContactCrud.instance.createController.stream.listen((contact) {
      if (contact is! Contact) return;

      add(AddContactHome(contact));
    });

    contactUpdateSubscription =
        ContactCrud.instance.updateController.stream.listen((contact) {
      if (contact is! Contact) return;

      add(UpdateContactHome(contact));
    });

    contactDeleteSubscription =
        ContactCrud.instance.deleteController.stream.listen((ids) {
      if (ids is! List<String>) return;

      add(DeleteContactHome(ids));
    });
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

      final processed = _processContacts(contacts);

      emit(state.copyWith(
        contacts: processed['contacts'],
        initialLetters: processed['initialLetters'],
        keys: processed['keys'],
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
    final confirmDelete = await CustomDialog.confirm(
      title: const Text('Confirm Deletion'),
      content: Text(
          'Are you sure you want to delete ${state.selectedContacts.length} selected contacts?'),
      actions: [
        TextButton(
          onPressed: () {
            AppKeys.getRootContext().pop(false);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            AppKeys.getRootContext().pop(true);
          },
          child: const Text('Delete'),
        ),
      ],
    );

    if (!confirmDelete) return;

    try {
      final ids = state.selectedContacts.map((contact) => contact.id).toList();

      final deletedIds = await ContactCrud.instance.delete(ids);

      emit(state.copyWith(
        selectedContacts: {},
        isSelectingContacts: false,
      ));

      add(DeleteContactHome(deletedIds));

      if (deletedIds.length > 1) {
        CustomSnackbar.success(
          text: '${deletedIds.length} contacts were deleted',
        );
      } else {
        CustomSnackbar.success(
          text: 'The contact was deleted',
        );
      }
    } catch (e) {
      CustomSnackbar.error(text: 'Something happened');
    }
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

  void _onAddContact(AddContactHome event, Emitter<HomeState> emit) {
    final newContacts = [...state.contacts, event.contact];

    final processed = _processContacts(newContacts);

    emit(state.copyWith(
      contacts: processed['contacts'],
      initialLetters: processed['initialLetters'],
      keys: processed['keys'],
    ));
  }

  void _onUpdateContact(UpdateContactHome event, Emitter<HomeState> emit) {
    final newContacts = state.contacts.map((contact) {
      return contact.id == event.contact.id ? event.contact : contact;
    }).toList();

    final processed = _processContacts(newContacts);

    emit(state.copyWith(
      contacts: processed['contacts'],
      initialLetters: processed['initialLetters'],
      keys: processed['keys'],
    ));
  }

  void _onDeleteContact(DeleteContactHome event, Emitter<HomeState> emit) {
    final newContacts = state.contacts.where((contact) {
      return !event.ids.contains(contact.id);
    }).toList();

    final processed = _processContacts(newContacts);

    emit(state.copyWith(
      contacts: processed['contacts'],
      initialLetters: processed['initialLetters'],
      keys: processed['keys'],
    ));
  }

  Future<void> _onSearchContacts(
    SearchContacts event,
    Emitter<HomeState> emit,
  ) async {
    List<Contact> contacts = await FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: true,
    );

    if (event.query.isNotEmpty) {
      contacts = contacts.where((contact) {
        return contact.displayName
            .toLowerCase()
            .contains(event.query.toLowerCase());
      }).toList();
    }

    final processed = _processContacts(contacts);

    emit(state.copyWith(
      selectedLetterIndex: 0,
      contacts: processed['contacts'],
      initialLetters: processed['initialLetters'],
      keys: processed['keys'],
    ));
  }
}
