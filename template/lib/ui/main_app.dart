import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/controller/authentication_controller.dart';
import '../domain/controller/messages_controller.dart';
import '../domain/controller/my_camera_controller.dart';
import '../domain/controller/storage_controller.dart';
import 'pages/central_page.dart';

class MainApp extends StatefulWidget {
  final CameraDescription camera;

  const MainApp({super.key, required this.camera});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  void initState() {
    // Inicializar controlador de camara
    Get.put(MyCameraController(widget.camera));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // Inyectar Controladores Get
    Get.put(AuthenticationController());
    Get.put(MessagesController());
    Get.put(StorageController());

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CentralPage(),
    );
  }
}
