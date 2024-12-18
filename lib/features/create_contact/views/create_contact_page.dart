import 'package:contacts_manager/alerts/alerts.dart';
import 'package:contacts_manager/cruds/cruds.dart';
import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateContactPage extends StatelessWidget {
  CreateContactPage({super.key});

  final FormGroup form = FormGroup({
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

  @override
  Widget build(BuildContext context) {
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    if (bottomPadding == 0) {
      bottomPadding = UISpacing.space4x;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text('Create Contact'),
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UISpacing.space4x,
              ),
              child: Column(
                children: [
                  const SizedBox(height: UISpacing.space4x),
                  ReactiveFormBuilder(
                    form: () => form,
                    builder: (context, form, child) {
                      return Column(
                        children: [
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
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(
                left: UISpacing.space4x,
                right: UISpacing.space4x,
                top: UISpacing.space4x,
                bottom: bottomPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                          style: UIButtonStyle.primaryFilled,
                          child: Text(
                            'Save Contact',
                            style: UITextStyle.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
