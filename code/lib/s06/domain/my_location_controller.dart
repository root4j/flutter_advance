import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../data/my_location.dart';

class MyLocationController extends GetxController {
  // Variable reactiva
  final _locations = <MyLocation>[].obs;

  // Variables de Firestore
  final _db = FirebaseFirestore.instance.collection('locations');
  final _events = FirebaseFirestore.instance.collection('locations').snapshots();
  late StreamSubscription<Object?> _subs;

  // Getter
  List<MyLocation> get locations => _locations;

  // Metodo para iniciar los listeners
  start() {
    _subs = _events.listen((event) {
      _locations.clear();
      for (var item in event.docs) {
        _locations.add(MyLocation.fromSnapshot(item));
      }
    });
  }

  // Metodo para detener los listeners
  stop() {
    _subs.cancel();
  }

  // Metodo para agregar localizacion
  Future<void> addLocation(MyLocation location) async {
    try {
      _db
          .add(location.toJson())
          .then((value) => Future.value(true))
          .catchError((error) => Future.value(false));
    } catch (e) {
      Future.error(e);
    }
  }
}