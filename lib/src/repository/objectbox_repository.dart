import 'dart:io';

import 'package:flutter/material.dart';
import 'package:objectbox_flutter/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxRepository {
  late Store store;
  final syncServerIp = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
  bool hasStoreInitialized = false;
  Stream? weatherStream;

  init() async {
    await getApplicationDocumentsDirectory().then((dir) {
      store = Store(
          // This method is from the generated file
          getObjectBoxModel(),
          directory: "${dir.path}/objectbox");
      Sync.client(store, 'ws://$syncServerIp:9999', SyncCredentials.none())
          .start();
      hasStoreInitialized = true;
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
