import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/messages_controller.dart';
import 'model/message.dart';

class FirebaseRealtimeBasic extends StatelessWidget {
  const FirebaseRealtimeBasic({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Firebase Realtime Basico'),
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
  MessagesController ctrl = Get.put(MessagesController());

  // Variables
  String message = "";

  void createMessage() async {
    try {
      Message msg = Message("rjay@mail.co", "Mensaje de Prueba");
      await ctrl.addMessage(msg);
      setState(() {
        message = "Mensaje Creado";
      });
    } catch (e) {
      setState(() {
        message = "Error $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    ctrl.start();
  }

  @override
  void dispose() {
    ctrl.stop();
    super.dispose();
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
          children: <Widget>[
            Text(
              message,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createMessage,
        tooltip: 'Crear Mensaje',
        child: const Icon(Icons.message),
      ),
    );
  }
}
