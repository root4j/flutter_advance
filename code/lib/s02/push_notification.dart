import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification extends StatelessWidget {
  const PushNotification({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notificacion Push'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Plugin
  late FlutterLocalNotificationsPlugin _fnp;

  @override
  void initState() {
    // Llamado de herencia
    super.initState();
    // Logica propia
    var ais = const AndroidInitializationSettings("message_icon");
    var iss = InitializationSettings(android: ais);
    _fnp = FlutterLocalNotificationsPlugin();
    _fnp.initialize(iss);
  }

  Future _showPushMessage() async {
    var ands = const AndroidNotificationDetails("channel-id-01", "channel-name",
        playSound: true, importance: Importance.high, priority: Priority.max);
    var nd = NotificationDetails(android: ands);
    _fnp.show(Random().nextInt(16), "Titulo", "Descripcion", nd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Notificacion',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPushMessage,
        tooltip: 'Generar Notificacion',
        child: const Icon(Icons.message),
      ),
    );
  }
}
