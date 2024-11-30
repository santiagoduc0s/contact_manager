import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestContactPermission extends StatelessWidget {
  const RequestContactPermission({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          openAppSettings();
        },
        child: const Text('Request Permission'),
      ),
    );
  }
}
