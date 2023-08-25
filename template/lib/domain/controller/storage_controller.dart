import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class StorageController extends GetxController {
  // Variable reactiva
  final _images = <Reference>[].obs;
  // Referencia de Storage
  final _ref = FirebaseStorage.instance.ref().child("images/");
  // Getters
  List<Reference> get images => _images;

  // Metodo de Inicio
  start() {
    _getImages();
  }

  // Metodo para obtener las imagenes
  void _getImages() async {
    _images.clear();
    var result = await _ref.list();
    _images.addAll(result.items);
  }

  // Metodo para guardar imagen en Firebase
  void addImageToFirebase(String path) {
    var uuid = const Uuid();
    var name = uuid.v4();
    var refSave = _ref.child("$name.jpg");
    var meta = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': path},
    );
    refSave.putFile(File(path), meta);
  }
}
