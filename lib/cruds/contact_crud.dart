import 'package:contacts_manager/cruds/crud.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactCrud extends CRUD {
  ContactCrud._();

  static final ContactCrud _instance = ContactCrud._();

  static ContactCrud get instance => _instance;

  Future<Contact> create({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    var newContact = Contact()
      ..name.first = firstName
      ..name.last = lastName
      ..phones = [Phone(phoneNumber)];

    newContact = await newContact.insert();

    createController.add(newContact);

    return newContact;
  }

  Future<Contact> update({
    required String id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final contact = (await FlutterContacts.getContact(id))!;

    contact.name.first = firstName;
    contact.name.last = lastName;
    contact.phones = [Phone(phoneNumber)];

    await contact.update();

    updateController.add(contact);

    return contact;
  }

  Future<List<String>> delete(List<String> ids) async {
    final tasks = ids.map((id) async {
      final contact = await FlutterContacts.getContact(id);
      if (contact == null) return null;

      await contact.delete();

      return id;
    }).toList();

    final results = await Future.wait(tasks);

    final deletedIds = results.whereType<String>().toList();

    deleteController.add(deletedIds);

    return deletedIds;
  }
}
