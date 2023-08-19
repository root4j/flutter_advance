import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/person.dart';

class PersonController extends GetxController {
  // Variable reactiva
  final _persons = <Person>[].obs;

  // Variables de Firestore
  final _db = FirebaseFirestore.instance.collection('persons');
  final _events = FirebaseFirestore.instance.collection('persons').snapshots();
  late StreamSubscription<Object?> _subs;

  // Getter
  List<Person> get persons => _persons;

  // Metodo para iniciar los listeners
  start() {
    _subs = _events.listen((event) {
      _persons.clear();
      for (var item in event.docs) {
        _persons.add(Person.fromSnapshot(item));
      }
    });
  }

  // Metodo para detener los listeners
  stop() {
    _subs.cancel();
  }

  // Metodo para agregar personas
  Future<void> addPerson(Person person, String user) async {
    try {
      _db
          .add(person.toJson(user))
          .then((value) => Future.value(true))
          .catchError((error) => Future.value(false));
    } catch (e) {
      Future.error(e);
    }
  }
}
