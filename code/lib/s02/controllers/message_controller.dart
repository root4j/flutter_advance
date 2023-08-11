import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageController extends GetxController {
  final List<String> messages = [
    "Sé el cambio que quieres ver en el mundo",
    "Te aguarda una larga y feliz vida.",
    "Hoy es el momento de explorar: no temas.",
    "Alégrate, un camino de hermosas rosas",
    "Si no puedes convencerlos, confúndelos. ",
    "Ya era tiempo que saliera de esta galleta.",
    "No renuncies a tus sueños... Sigue durmiendo.",
    "Veo dinero en tu futuro. Aunque no es tuyo.",
    "Tu ignorancia es enciclopédica.",
    "Si el mundo es un pañuelo, ¿nosotros qué somos?"
  ];

  // Plugin
  late FlutterLocalNotificationsPlugin _fnp;

  MessageController() {
    // Logica propia
    var ais = const AndroidInitializationSettings("message_icon");
    var iss = InitializationSettings(android: ais);
    _fnp = FlutterLocalNotificationsPlugin();
    _fnp.initialize(iss);
  }

  Future showMotivationalMessage() async {
    var ands = const AndroidNotificationDetails("channel-id-01", "channel-name",
        playSound: true, importance: Importance.high, priority: Priority.max);
    var nd = NotificationDetails(android: ands);
    var title = DateFormat("yyyy-MM-dd kk:mm").format(DateTime.now());
    var message = messages[Random().nextInt(15)];
    _fnp.show(Random().nextInt(256), title, message, nd);
  }
}
