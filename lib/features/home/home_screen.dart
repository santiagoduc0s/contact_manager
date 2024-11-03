import 'dart:math';
import 'package:contacts_manager/features/create_contact/create_contact_screen.dart';
import 'package:contacts_manager/features/edit_contact/edit_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool _permissionGranted = false;
  bool _permissionRequestedAndDenied = false;
  bool _isFetching = false;
  bool _isSelecting = false;
  List<Contact> _contacts = [];
  final Set<Contact> _selectedContacts = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    bool granted = await FlutterContacts.requestPermission();
    setState(() {
      _permissionGranted = granted;
      _permissionRequestedAndDenied = !granted;
    });

    if (granted) {
      _fetchContacts();
    }
  }

  void _openAppSettings() {
    openAppSettings();
  }

  Future<void> _fetchContacts() async {
    setState(() {
      _isFetching = true;
      _contacts.clear();
    });

    await Future.delayed(const Duration(seconds: 1));

    List<Contact> contacts = await FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: true,
    );

    contacts.sort((a, b) {
      String nameA =
          a.displayName.isNotEmpty ? a.displayName.toLowerCase() : 'unnamed';
      String nameB =
          b.displayName.isNotEmpty ? b.displayName.toLowerCase() : 'unnamed';
      return nameA.compareTo(nameB);
    });

    setState(() {
      _contacts = contacts;
      _isFetching = false;
    });
  }

  Future<void> _createRandomContact() async {
    final random = Random();
    String randomInitial = String.fromCharCode(random.nextInt(26) + 65);

    final newContact = Contact()
      ..name.first = '$randomInitial${random.nextInt(1000)}'
      ..name.last = 'User'
      ..phones = [Phone('555-${random.nextInt(1000)}-${random.nextInt(1000)}')];

    await newContact.insert();
    _fetchContacts();
  }

  Future<void> _confirmDeleteSelectedContacts() async {
    var confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text(
              'Are you sure you want to delete ${_selectedContacts.length} selected contacts?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      _deleteSelectedContacts();
    }
  }

  Future<void> _deleteSelectedContacts() async {
    for (Contact contact in _selectedContacts) {
      await contact.delete();
    }
    _selectedContacts.clear();
    _isSelecting = false;
    _fetchContacts();
  }

  Future<void> _navigateToCreateContactPage() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CreateContactScreen()),
    );

    if (result == true) {
      _fetchContacts();
    }
  }

  void _toggleSelection(Contact contact) {
    setState(() {
      if (_selectedContacts.contains(contact)) {
        _selectedContacts.remove(contact);
      } else {
        _selectedContacts.add(contact);
      }
    });
  }

  void _cancelSelection() {
    setState(() {
      _isSelecting = false;
      _selectedContacts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(.4),
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        title: const Text('Contacts'),
        actions: [
          if (_isSelecting && _selectedContacts.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline_outlined),
              onPressed: _confirmDeleteSelectedContacts,
            ),
          IconButton(
            icon: _isSelecting
                ? const Icon(Icons.cancel_outlined)
                : const Icon(Icons.select_all),
            onPressed: () {
              if (_isSelecting) {
                _cancelSelection();
              } else {
                setState(() {
                  _isSelecting = true;
                });
              }
            },
          ),
        ],
      ),
      body: Center(
        child: _permissionGranted
            ? _isFetching
                ? const CircularProgressIndicator()
                : _contacts.isEmpty
                    ? const Text(
                        'No contacts found. Tap the button to fetch contacts.',
                      )
                    : ListView.builder(
                        itemCount: _contacts.length,
                        itemBuilder: (context, index) {
                          Contact contact = _contacts[index];
                          bool isSelected = _selectedContacts.contains(contact);

                          String displayName = contact.displayName.isNotEmpty
                              ? contact.displayName
                              : 'Unnamed Contact';

                          bool showDivider = index == 0 ||
                              displayName.trim()[0].toUpperCase() !=
                                  (_contacts[index - 1].displayName.isNotEmpty
                                      ? _contacts[index - 1]
                                          .displayName
                                          .trim()[0]
                                          .toUpperCase()
                                      : 'U');

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (showDivider)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4.0),
                                  child: Text(
                                    displayName[0].toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ListTile(
                                tileColor: isSelected
                                    ? Colors.deepPurple.withOpacity(0.2)
                                    : null,
                                leading: contact.photo != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            MemoryImage(contact.photo!),
                                      )
                                    : const CircleAvatar(
                                        child: Icon(Icons.person),
                                      ),
                                title: Text(
                                  '${contact.name.first} ${contact.name.last}',
                                  style: isSelected
                                      ? const TextStyle(
                                          color: Colors.deepPurple)
                                      : null,
                                ),
                                subtitle: Text(
                                  contact.phones.isNotEmpty
                                      ? contact.phones.first.number
                                      : 'No phone number',
                                  style: isSelected
                                      ? const TextStyle(
                                          color: Colors.deepPurple)
                                      : null,
                                ),
                                onTap: _isSelecting
                                    ? () {
                                        _toggleSelection(contact);
                                      }
                                    : () async {
                                        final editedContact =
                                            await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditContactScreen(
                                                    contact: contact),
                                          ),
                                        );

                                        if (editedContact != null &&
                                            editedContact is Contact) {
                                          setState(() {
                                            _contacts[index] = editedContact;
                                          });
                                        }
                                      },
                              )
                            ],
                          );
                        },
                      )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_permissionRequestedAndDenied)
                    Column(
                      children: [
                        const Text(
                            'Contacts permission denied. Please enable access.'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _openAppSettings,
                          child: const Text('Open Settings'),
                        ),
                      ],
                    ),
                  if (!_permissionRequestedAndDenied)
                    ElevatedButton(
                      onPressed: _checkPermission,
                      child: const Text('Request Permission'),
                    ),
                ],
              ),
      ),
      floatingActionButton: _permissionGranted && !_isSelecting
          ? FloatingActionButton(
              heroTag: 'goToCreateContactPage',
              onPressed: _navigateToCreateContactPage,
              tooltip: 'Go to Create Contact Page',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
