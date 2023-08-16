import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../model/message.dart';

class MessagesController extends GetxController {
  // Contante
  final String dbName = "messages";
  // Mi varible reactiva
  var messages = <Message>[].obs;
  // Variables de Firebase Database
  final db = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> newData;
  late StreamSubscription<DatabaseEvent> updateData;

  // Metodo para iniciar Firebase Database
  start() {
    messages.clear();
    newData = db.child(dbName).onChildAdded.listen(_onCreateData);
    updateData = db.child(dbName).onChildChanged.listen(_onUpdateData);
  }

  // Metodo para detener Firebase Database
  stop() {
    newData.cancel();
    updateData.cancel();
  }

  // Metodo para escuchar nuevos registros
  _onCreateData(DatabaseEvent event) {
    final json = event.snapshot.value as Map<dynamic, dynamic>;
    messages.add(Message.fromJSON(event.snapshot, json));
  }

  // Metodo para escuchar actualizaciones de registros
  _onUpdateData(DatabaseEvent event) {
    var oldMessage = messages.singleWhere((element) {
      return element.key == event.snapshot.key;
    });

    final json = event.snapshot.value as Map<dynamic, dynamic>;
    messages[messages.indexOf(oldMessage)] =
        Message.fromJSON(event.snapshot, json);
  }

  // Metodo para agregar datos
  Future<void> addMessage(Message msg) async {
    try {
      db.child(dbName).push().set(msg.toJSON());
    } catch (e) {
      return Future.error(e);
    }
  }
}
