import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:contacts_manager/features/home/widgets/contact_item.dart';
import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final contacts = context.select((HomeBloc bloc) => bloc.state.contacts);

    final selectedContacts =
        context.select((HomeBloc bloc) => bloc.state.selectedContacts);

    final isSelectingContacts =
        context.select((HomeBloc bloc) => bloc.state.isSelectingContacts);

    final keyValues = context.select((HomeBloc bloc) => bloc.state.keys);

    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: Colors.deepPurple.shade200,
            height: UISpacing.space8x + UISpacing.px2,
            child: Row(
              children: [
                const SizedBox(width: UISpacing.space4x),
                Text('Contacts', style: UITextStyle.headlineSmall),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: _PersistentHeaderDelegate(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: UISpacing.space2x,
                  horizontal: UISpacing.space3x,
                ),
                child: TextField(
                  cursorHeight: UISpacing.space4x,
                  onChanged: (value) {
                    context.read<HomeBloc>().add(SearchContacts(value));
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(UISpacing.space2x),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                ),
              ),
            ),
          ),
        ),
        contacts.isEmpty
            ? const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('No contacts found.'),
                    ],
                  ),
                ),
              )
            : SliverToBoxAdapter(
                child: Column(
                  children: contacts.map((contact) {
                    int index = contacts.indexOf(contact);
                    bool isSelected = selectedContacts.contains(contact);

                    String displayName = contact.displayName;
                    String firstLetterOfName =
                        displayName.trim()[0].toUpperCase();
                    String firstLetterOfThePreviousName = index == 0
                        ? ''
                        : contacts[index - 1]
                            .displayName
                            .trim()[0]
                            .toUpperCase();

                    bool showDivider = index == 0 ||
                        firstLetterOfName != firstLetterOfThePreviousName;

                    final key = keyValues[firstLetterOfName];

                    return ContactItem(
                      keyDivider: key,
                      showDivider: showDivider,
                      firstLetterOfName: firstLetterOfName,
                      isSelected: isSelected,
                      contact: contact,
                      isSelectingContacts: isSelectingContacts,
                    );
                  }).toList(),
                ),
              ),
        SliverPadding(
          padding: EdgeInsets.only(bottom: bottomPadding),
        ),
      ],
    );
  }
}

class _PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _PersistentHeaderDelegate({required this.child});

  @override
  double get minExtent => UISpacing.space12x;
  @override
  double get maxExtent => UISpacing.space12x;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.deepPurple.shade200),
        ),
        Align(
          alignment: Alignment.center,
          child: child,
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
