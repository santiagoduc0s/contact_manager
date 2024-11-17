import 'package:contacts_manager/features/create_contact/create_contact_screen.dart';
import 'package:contacts_manager/features/edit_contact/edit_contact_screen.dart';
import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int letter = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> confirmDeleteSelectedContacts(BuildContext context) async {
    final selectedContacts = context.read<HomeBloc>().state.selectedContacts;

    var confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text(
              'Are you sure you want to delete ${selectedContacts.length} selected contacts?'),
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
      if (!context.mounted) return;
      context.read<HomeBloc>().add(const DeleteSelectedContacts());
    }
  }

  Future<void> navigateToCreateContactPage() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CreateContactScreen()),
    );

    if (result == true) {}
  }

  @override
  Widget build(BuildContext context) {
    final contacts = context.select((HomeBloc bloc) => bloc.state.contacts);

    final permissionGranted =
        context.select((HomeBloc bloc) => bloc.state.permissionGranted);

    final isFetchingContacts =
        context.select((HomeBloc bloc) => bloc.state.isFetchingContacts);

    final selectedContacts =
        context.select((HomeBloc bloc) => bloc.state.selectedContacts);

    final isSelectingContacts =
        context.select((HomeBloc bloc) => bloc.state.isSelectingContacts);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(.4),
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        title: const Text('Contacts'),
        actions: [
          if (isSelectingContacts && selectedContacts.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline_outlined),
              onPressed: () {
                confirmDeleteSelectedContacts(context);
              },
            ),
          IconButton(
            icon: isSelectingContacts
                ? const Icon(Icons.cancel_outlined)
                : const Icon(Icons.select_all),
            onPressed: () {
              context.read<HomeBloc>().add(const ToggleIsSelectingContacts());
            },
          ),
        ],
      ),
      body: permissionGranted
          ? isFetchingContacts
              ? const Center(child: CircularProgressIndicator())
              : contacts.isEmpty
                  ? const Center(
                      child: Text(
                        'No contacts found. Tap the button to fetch contacts.',
                      ),
                    )
                  : Stack(
                      children: [
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            Contact contact = contacts[index];
                            bool isSelected =
                                selectedContacts.contains(contact);

                            String displayName = contact.displayName.isNotEmpty
                                ? contact.displayName
                                : 'Unnamed Contact';

                            bool showDivider = index == 0 ||
                                displayName.trim()[0].toUpperCase() !=
                                    (contacts[index - 1].displayName.isNotEmpty
                                        ? contacts[index - 1]
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
                                  onTap: isSelectingContacts
                                      ? () {
                                          context
                                              .read<HomeBloc>()
                                              .add(SelectContact(contact));
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
                                              contacts[index] = editedContact;
                                            });
                                          }
                                        },
                                )
                              ],
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 500,
                            width: 70,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackShape: RotatedLetterSliderTrackShape(),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: 25,
                                  value: letter.toDouble(),
                                  label: String.fromCharCode(65 + letter),
                                  onChanged: (newValue) {
                                    setState(() {
                                      letter = newValue.toInt();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!permissionGranted)
                  ElevatedButton(
                    onPressed: () {
                      openAppSettings();
                    },
                    child: const Text('Request Permission'),
                  ),
              ],
            ),
      floatingActionButton: permissionGranted && !isSelectingContacts
          ? FloatingActionButton(
              heroTag: 'goToCreateContactPage',
              onPressed: navigateToCreateContactPage,
              tooltip: 'Go to Create Contact Page',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class RotatedLetterSliderTrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 40.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    if (sliderTheme.trackHeight == null ||
        sliderTheme.activeTrackColor == null ||
        sliderTheme.inactiveTrackColor == null) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    final List<String> alphabet = List.generate(
      26,
      (index) => String.fromCharCode(65 + index),
    ); // A-Z

    final double letterSpacing = trackRect.width / (alphabet.length - 1);

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < alphabet.length; i++) {
      final String letter = alphabet[i];
      final double letterX = trackRect.left + (i * letterSpacing);
      final double letterY = trackRect.top + trackRect.height / 2;

      textPainter.text = TextSpan(
        text: letter,
        style: TextStyle(
          color: sliderTheme.activeTrackColor,
          fontSize: 14.0,
        ),
      );

      textPainter.layout();

      // Rotate canvas to draw vertical letters
      context.canvas.save();
      context.canvas.translate(letterX, letterY); // Move to letter position
      context.canvas.rotate(-90 * 3.14159 / 180); // Rotate by -90 degrees
      textPainter.paint(
        context.canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      context.canvas.restore(); // Restore canvas state
    }
  }
}
