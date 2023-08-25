import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/my_camera_controller.dart';
import '../../domain/my_storage_controller.dart';
import '../widgets/camera_widget.dart';
import '../widgets/list_image_widget.dart';
import '../widgets/preview_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variables
  int _index = 0;
  // Listado de Widgets
  final List<Widget> _widgets = <Widget>[
    const CameraWidget(),
    const PreviewWidget(),
    const ListImageWidget(),
  ];
  // Controladores
  MyCameraController ctrl = Get.find();
  MyStorageController stgCtrl = Get.find();

  // Logica de disparo de la camara
  void _takePicture() async {
    // Verificar si la camara esta inicializada
    if (ctrl.initCamera) {
      try {
        // Tomar foto
        final image = await ctrl.controller.takePicture();
        // Asignar el path de la foto a nuestro controlador
        ctrl.path = image.path;
        // Guardar imagen en Firebase
        stgCtrl.addImageToFirebase(image.path);
        // Cambiar el indice de los widgets
        setState(() {
          _index = 1;
        });
      } catch (e) {
        logError(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camara Demo"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 500,
            ),
            child: _widgets.elementAt(_index),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
        visible: _index == 0,
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
