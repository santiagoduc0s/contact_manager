import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class EditContactScreen extends StatefulWidget {
  final Contact contact;

  const EditContactScreen({super.key, required this.contact});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();

    _firstNameController =
        TextEditingController(text: widget.contact.name.first);
    _lastNameController = TextEditingController(text: widget.contact.name.last);
    _phoneController = TextEditingController(
      text: widget.contact.phones.isNotEmpty
          ? widget.contact.phones.first.number
          : '',
    );
  }

  @override
  dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _updateContact() async {
    widget.contact.name.first = _firstNameController.text;
    widget.contact.name.last = _lastNameController.text;

    if (widget.contact.phones.isNotEmpty) {
      widget.contact.phones.first.number = _phoneController.text;
    } else {
      widget.contact.phones.add(Phone(_phoneController.text));
    }

    await widget.contact.update();

    if (!mounted) return;
    Navigator.of(context).pop(widget.contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateContact,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
