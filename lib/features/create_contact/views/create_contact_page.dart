import 'package:contacts_manager/alerts/alerts.dart';
import 'package:contacts_manager/cruds/cruds.dart';
import 'package:contacts_manager/ui/ui_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateContactPage extends StatelessWidget {
  const CreateContactPage({super.key});

  Future<void> _saveContact(BuildContext context) async {
    try {
      final contact = await ContactCrud.instance.create(
        firstName: form.control('firstName').value,
        lastName: form.control('lastName').value,
        phoneNumber: form.control('phone').value,
      );

      CustomSnackbar.success(text: '${contact.name.first} was created');

      if (!context.mounted) return;

      context.pop();
    } catch (e) {
      CustomSnackbar.error(text: 'Something happened');
      return;
    }
  }

  FormGroup get form => FormGroup({
        'firstName': FormControl<String>(
          value: '',
          validators: [Validators.required],
        ),
        'lastName': FormControl<String>(
          value: '',
          validators: [],
        ),
        'phone': FormControl<String>(
          value: '',
          validators: [Validators.required],
        ),
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text('Create Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(UISpacing.space4x),
        child: ReactiveFormBuilder(
            form: () => form,
            builder: (context, form, child) {
              return Column(
                children: [
                  ReactiveTextField<String>(
                    formControlName: 'firstName',
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(UISpacing.space3x),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(UISpacing.space3x),
                      ),
                    ),
                  ),
                  const SizedBox(height: UISpacing.space4x),
                  ReactiveTextField<String>(
                    formControlName: 'lastName',
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(UISpacing.space3x),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(UISpacing.space3x),
                      ),
                    ),
                  ),
                  const SizedBox(height: UISpacing.space4x),
                  ReactiveTextField<String>(
                    formControlName: 'phone',
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(UISpacing.space3x),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(UISpacing.space3x),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            if (form.valid) {
                              _saveContact(context);
                            } else {
                              form.markAllAsTouched();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: const Text(
                            'Save Contact',
                            style: TextStyle(fontSize: 15),
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
