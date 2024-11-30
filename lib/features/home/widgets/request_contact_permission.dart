import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RequestContactPermission extends StatelessWidget {
  const RequestContactPermission({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final permissionGranted =
        context.select((HomeBloc bloc) => bloc.state.permissionGranted);

    return Column(
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
    );
  }
}