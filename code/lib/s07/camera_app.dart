import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'domain/my_camera_controller.dart';
import 'domain/my_storage_controller.dart';
import 'ui/pages/home_page.dart';

class CameraApp extends StatefulWidget {
  final CameraDescription camera;

  const CameraApp({super.key, required this.camera});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {

  @override
  void initState() {
    // Inicializar controlador de camara
    Get.put(MyCameraController(widget.camera));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Inicializar controladores
    Get.put(MyStorageController());

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
