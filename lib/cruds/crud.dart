import 'dart:async';

class CustomException implements Exception {
  CustomException(this.error, [this.stackTrace]);

  final Object error;
  final StackTrace? stackTrace;
}

class CRUD {
  CRUD({
    StreamController<Object>? createController,
    StreamController<Object>? updateController,
    StreamController<Object>? deleteController,
  })  : createController =
            createController ?? StreamController<Object>.broadcast(),
        updateController =
            updateController ?? StreamController<Object>.broadcast(),
        deleteController =
            deleteController ?? StreamController<Object>.broadcast();

  final StreamController<Object> createController;
  final StreamController<Object> updateController;
  final StreamController<Object> deleteController;
}
