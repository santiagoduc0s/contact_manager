import 'package:contacts_manager/cruds/crud.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactCrud extends CRUD {
  ContactCrud._();

  static final ContactCrud _instance = ContactCrud._();

  static ContactCrud get instance => _instance;

  Future<void> create({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      var newContact = Contact()
        ..name.first = firstName
        ..name.last = lastName
        ..phones = [Phone(phoneNumber)];

      newContact = await newContact.insert();

      createController.add(newContact);
    } catch (e, s) {
      createController.add(CustomException(e, s));
    }
  }
}
