import 'package:contacts_manager/alerts/alerts.dart';
import 'package:contacts_manager/cruds/cruds.dart';
import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditContactPage extends StatefulWidget {
  final Contact contact;

  const EditContactPage({super.key, required this.contact});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();

    form = FormGroup({
      'firstName': FormControl<String>(
        value: widget.contact.name.first,
        validators: [Validators.required],
      ),
      'lastName': FormControl<String>(
        value: widget.contact.name.last,
        validators: [],
      ),
      'phone': FormControl<String>(
        value: widget.contact.phones.isNotEmpty
            ? widget.contact.phones.first.number
            : '',
        validators: [Validators.required],
      ),
    });
  }

  Future<void> _updateContact(BuildContext context) async {
    try {
      final contact = await ContactCrud.instance.update(
        id: widget.contact.id,
        firstName: form.control('firstName').value,
        lastName: form.control('lastName').value,
        phoneNumber: form.control('phone').value,
      );

      CustomSnackbar.success(text: '${contact.name.first} was updated');

      if (!context.mounted) return;

      context.pop();
    } catch (e) {
      CustomSnackbar.error(text: 'Something happened');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text('Edit Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: UISpacing.space4x,
          bottom: bottomPadding > 0 ? bottomPadding : UISpacing.space4x,
          left: UISpacing.space4x,
          right: UISpacing.space4x,
        ),
        child: ReactiveFormBuilder(
            form: () => form,
            builder: (context, form, child) {
              return Column(
                children: [
                  Hero(
                    tag: widget.contact.id,
                    child: widget.contact.photo != null
                        ? CircleAvatar(
                            radius: UISpacing.space20x,
                            backgroundImage: MemoryImage(widget.contact.photo!),
                          )
                        : const CircleAvatar(
                            radius: UISpacing.space20x,
                            child: Icon(
                              Icons.person,
                              size: UISpacing.space19x,
                            ),
                          ),
                  ),
                  const SizedBox(height: UISpacing.space4x),
                  ReactiveTextField<String>(
                    formControlName: 'firstName',
                    textInputAction: TextInputAction.next,
                    decoration: UIInputStyle.defaultStyle.copyWith(
                      labelText: 'First Name',
                    ),
                  ),
                  const SizedBox(height: UISpacing.space4x),
                  ReactiveTextField<String>(
                    formControlName: 'lastName',
                    textInputAction: TextInputAction.next,
                    decoration: UIInputStyle.defaultStyle.copyWith(
                      labelText: 'Last Name',
                    ),
                  ),
                  const SizedBox(height: UISpacing.space4x),
                  ReactiveTextField<String>(
                    formControlName: 'phone',
                    textInputAction: TextInputAction.done,
                    decoration: UIInputStyle.defaultStyle.copyWith(
                      labelText: 'Phone Number',
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            if (form.valid) {
                              _updateContact(context);
                            } else {
                              form.markAllAsTouched();
                            }
                          },
                          style: UIButtonStyle.primaryFilled,
                          child: Text(
                            'Edit Contact',
                            style: UITextStyle.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
