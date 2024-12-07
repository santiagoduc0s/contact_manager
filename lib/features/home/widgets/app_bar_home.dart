import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:contacts_manager/ui/ui_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(UISpacing.space10x);

  @override
  Widget build(BuildContext context) {
    bool isFetchingContacts =
        context.select((HomeBloc bloc) => bloc.state.isFetchingContacts);

    final selectedContacts =
        context.select((HomeBloc bloc) => bloc.state.selectedContacts);

    final isSelectingContacts =
        context.select((HomeBloc bloc) => bloc.state.isSelectingContacts);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.deepPurple.shade200,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leadingWidth: UISpacing.space50x,
      leading: Row(
        children: [
          ZoomIn(
            animate: !isFetchingContacts,
            child: IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: isSelectingContacts
                    ? const Icon(
                        Icons.close,
                        key: ValueKey('closeIcon'),
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.select_all,
                        key: ValueKey('selectAllIcon'),
                        color: Colors.black,
                      ),
              ),
              onPressed: () => context
                  .read<HomeBloc>()
                  .add(const ToggleIsSelectingContacts()),
            ),
          ),
          ZoomIn(
            animate: isSelectingContacts,
            duration: const Duration(milliseconds: 300),
            child: Chip(
              label: Text("Contacts: ${selectedContacts.length}"),
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(UISpacing.space10x),
                side: const BorderSide(width: UISpacing.zero),
              ),
              backgroundColor: Colors.deepPurple.shade400,
            ),
          ),
        ],
      ),
      actions: [
        ZoomIn(
          duration: const Duration(milliseconds: 300),
          animate: isSelectingContacts && selectedContacts.isNotEmpty,
          child: IconButton(
            icon: const Icon(
              Icons.delete_outline_outlined,
              color: Colors.black,
            ),
            onPressed: () =>
                context.read<HomeBloc>().add(const DeleteSelectedContacts()),
          ),
        ),
      ],
    );
  }
}
