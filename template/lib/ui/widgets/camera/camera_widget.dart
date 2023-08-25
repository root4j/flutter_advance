import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controller/my_camera_controller.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  // Controladores
  MyCameraController ctrl = Get.find();

  // Futuro para inicializar el controlodor de la camara
  late Future<void> _initCamFuture;

  @override
  void initState() {
    super.initState();
    // Iniciar controlador de la camara
    ctrl.controller = CameraController(ctrl.camera, ResolutionPreset.max);
    // Inicializar futuro del controlador
    _initCamFuture = ctrl.controller.initialize();
  }

  @override
  void dispose() {
    // Destruir el controlador de la camara
    ctrl.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initCamFuture,
      builder: (context, snapshot) {
        // Luego de resolver el estado del futuro muestra la
        // previsulizacion de la camara
        if (snapshot.connectionState == ConnectionState.done) {
          ctrl.initCamera = true;
          return CameraPreview(ctrl.controller);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
