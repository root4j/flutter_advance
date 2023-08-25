import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

import 'ui/main_app.dart';

Future<void> main() async {
  // Validacion de Inicio base de Widgets
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar Loggy
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(showColors: true),
  );
  // Iniciar Firebase
  await Firebase.initializeApp();
  // Obtener camaras del dispositivo
  final cameras = await availableCameras();
  // Obtener la camara principal
  final mainCamera = cameras.first;
  // Inicio la aplicacion con los parametros iniciales
  runApp(
    MainApp(
      camera: mainCamera,
    ),
  );
}
