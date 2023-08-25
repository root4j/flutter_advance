import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../data/message.dart';

class MessagesController extends GetxController {
  // Contante
  final String _dbName = "messages";
  // Mi varible reactiva
  var messages = <Message>[].obs;
  // Variables de Firebase Database
  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> _newData;
  late StreamSubscription<DatabaseEvent> _updateData;

  // Metodo para iniciar Firebase Database
  start() {
    messages.clear();
    _newData = _db.child(_dbName).onChildAdded.listen(_onCreateData);
    _updateData = _db.child(_dbName).onChildChanged.listen(_onUpdateData);
  }

  // Metodo para detener Firebase Database
  stop() {
    _newData.cancel();
    _updateData.cancel();
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
      _db.child(_dbName).push().set(msg.toJSON());
    } catch (e) {
      return Future.error(e);
    }
  }

  // Metodo para actualizar datos
  Future<void> updateMessage(Message msg) async {
    try {
      _db.child(_dbName).child(msg.key!).set(msg.toJSON());
    } catch (e) {
      return Future.error(e);
    }
  }

  // Metodo para eliminar datos
  Future<void> deleteMessage(Message msg, int index) async {
    try {
      _db
          .child(_dbName)
          .child(msg.key!)
          .remove()
          .then((value) => messages.removeAt(index));
    } catch (e) {
      return Future.error(e);
    }
  }
}
