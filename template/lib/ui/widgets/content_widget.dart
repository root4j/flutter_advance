import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/controller/authentication_controller.dart';
import '../../domain/controller/my_camera_controller.dart';
import '../../domain/controller/storage_controller.dart';
import 'camera/camera_widget.dart';
import 'camera/list_image_widget.dart';
import 'camera/preview_widget.dart';
import 'msg/message_widget.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  // Variables
  int _index = 0;
  // Listado de Widgets
  final List<Widget> _widgets = <Widget>[
    const MessageWidget(),
    const CameraWidget(),
    const PreviewWidget(),
    const ListImageWidget(),
  ];
  // Controladores
  AuthenticationController authCtrl = Get.find();
  MyCameraController camCtrl = Get.find();
  StorageController stgCtrl = Get.find();

  // Metodo para cerrar sesion
  _logout() async {
    try {
      await authCtrl.signOut();
    } catch (e) {
      logError(e);
    }
  }

  // Logica de disparo de la camara
  void _takePicture() async {
    // Verificar si la camara esta inicializada
    if (camCtrl.initCamera) {
      try {
        // Tomar foto
        final image = await camCtrl.controller.takePicture();
        // Asignar el path de la foto a nuestro controlador
        camCtrl.path = image.path;
        // Guardar imagen en Firebase
        stgCtrl.addImageToFirebase(image.path);
        // Cambiar el indice de los widgets
        setState(() {
          _index = 2;
        });
      } catch (e) {
        logError(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = authCtrl.getMail();
    return Scaffold(
      appBar: AppBar(
        title: Text(user),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: _widgets.elementAt(_index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            label: "Mensajes",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
            ),
            label: "Camara",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo,
            ),
            label: "Preview",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_album,
            ),
            label: "Listado",
          ),
        ],
        currentIndex: _index,
        selectedItemColor: Colors.blue,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
      floatingActionButton: Visibility(
        visible: _index == 1,
        child: FloatingActionButton(
          onPressed: _takePicture,
          child: const Icon(
            Icons.camera,
          ),
        ),
      ),
    );
  }
}
