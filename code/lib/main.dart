import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:workmanager/workmanager.dart';

import 's01/check_signal_basic.dart';
import 's01/check_signal_get.dart';
import 's02/controllers/message_controller.dart';
import 's02/local_notification.dart';
import 's02/push_notification.dart';
import 's02/workmanager_basic.dart';
import 's03/firebase_login_basic.dart';
import 's03/firebase_login_form.dart';
import 's03/firebase_realtime_basic.dart';
import 's03/firebase_realtime_visual.dart';
import 's03/firebase_widget.dart';
import 's04/firebase_firestore.dart';
import 's05/ui/geo_location_basic.dart';
import 's06/firebase_geo_location.dart';

// Metodos Dispatcher
void callbackDispatcherMessage() async {
  Workmanager().executeTask((taskName, inputData) async {
    MessageController ctrl = Get.put(MessageController());
    ctrl.showMotivationalMessage();
    return Future.value(true);
  });
}

// Metodo Principal
Future<void> main() async {
  // Validacion de Inicio base de Widgets
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar Loggy
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(showColors: true),
  );
  // Clase que se ejecutara
  var tipo = Tipos.firebaseGeoLocation;
  // Condicional de clases
  switch (tipo) {
    case Tipos.checkSignalBasic:
      runApp(const CheckSignalBasic());
      break;
    case Tipos.checkSignalGet:
      runApp(const CheckSignalGet());
      break;
    case Tipos.localNotification:
      runApp(const LocalNotification());
      break;
    case Tipos.pushNotification:
      runApp(const PushNotification());
      break;
    case Tipos.backgroundTaskMessage:
      // Inicializar tarea
      await Workmanager().initialize(callbackDispatcherMessage);
      // Registro de la tarea
      await Workmanager().registerPeriodicTask(
          "pt-task-1", "print-date-console",
          frequency: const Duration(minutes: 15));
      // Iniciar Pantalla
      runApp(const WorkmanagerBasic());
      break;
    case Tipos.flutterFireBasic:
      // Iniciar Firebase
      await Firebase.initializeApp();
      runApp(const FirebaseWidget());
      break;
    case Tipos.flutterFireAuthBasic:
      // Iniciar Firebase
      await Firebase.initializeApp();
      runApp(const FirebaseLoginBasic());
      break;
    case Tipos.flutterFireAuthForm:
      // Iniciar Firebase
      await Firebase.initializeApp();
      runApp(const FirebaseLoginForm());
      break;
    case Tipos.flutterFireRealBasic:
      // Iniciar Firebase
      await Firebase.initializeApp();
      runApp(const FirebaseRealtimeBasic());
      break;
    case Tipos.flutterFireRealVisual:
      // Iniciar Firebase
      await Firebase.initializeApp();
      runApp(const FirebaseRealtimeVisual());
      break;
    case Tipos.flutterFirestore:
      // Iniciar Firebase
      await Firebase.initializeApp();
      runApp(const FirebaseFirestore());
      break;
    case Tipos.flutterGeoLocationBasic:
      runApp(const GeoLocationBasic());
      break;
    case Tipos.firebaseGeoLocation:
      // Iniciar Firebase
      await Firebase.initializeApp();
      runApp(const FirebaseGeoLocation());
      break;
    default:
      runApp(const CheckSignalBasic());
      break;
  }
}

// Enumeracion para ejecucion principal de Wigets
enum Tipos {
  checkSignalBasic,
  checkSignalGet,
  localNotification,
  pushNotification,
  backgroundTaskMessage,
  flutterFireBasic,
  flutterFireAuthBasic,
  flutterFireAuthForm,
  flutterFireRealBasic,
  flutterFireRealVisual,
  flutterFirestore,
  flutterGeoLocationBasic,
  firebaseGeoLocation
}
