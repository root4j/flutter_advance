import 'dart:math';

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
  final List<String> msgs = [
    "Lorem ipsum dolor sit amet",
    "Consectetur adipiscing elit",
    "Quisque in dignissim turpis",
    "Pellentesque sem lacus",
    "Elementum eu eros non",
    "Luctus tempor magna",
    "Nam non nisi eu magna suscipit laoreet",
    "Mauris urna ante, luctus nec purus at",
    "Sodales consectetur turpis",
    "Donec imperdiet pulvinar dui",
    "In lobortis neque feugiat sed",
    "Cras laoreet odio et vulputate euismod",
    "In hac habitasse platea dictumst",
    "Duis hendrerit consequat ante eget volutpat",
    "Maecenas facilisis varius lobortis"
  ];
  final List<String> emails = [
    "rjay@mail.co",
    "rjay1@mail.pe",
    "rjay2@mail.us",
    "rjay3@unimail.co",
    "rjay4@uninorte.co",
    "rjay5@guayacan.co",
    "rjay6@pomelo.co",
    "rjay7@roble.co"
  ];

  MessagesController ctrl = Get.put(MessagesController());

  // Variables
  String message = "";

  void createMessage() async {
    try {
      Message msg =
          Message(emails[Random().nextInt(8)], msgs[Random().nextInt(15)]);
      await ctrl.addMessage(msg);
      setState(() {
        var size = ctrl.messages.length;
        message = "Mensaje Creado [$size]";
      });
    } catch (e) {
      setState(() {
        message = "Error $e";
      });
    }
  }

  void updateMessage() async {
    try {
      var msgsArray = ctrl.messages;
      if (msgsArray.isNotEmpty) {
        Message msg = msgsArray[Random().nextInt(msgsArray.length)];
        msg.text = "${msg.text}. Update";
        await ctrl.updateMessage(msg);
        setState(() {
          var size = ctrl.messages.length;
          message = "Mensaje Actualizado [$size]";
        });
      } else {
        setState(() {
          message = "No hay mensajes";
        });
      }
    } catch (e) {
      setState(() {
        message = "Error $e";
      });
    }
  }

  void deleteMessage() async {
    try {
      var msgsArray = ctrl.messages;
      if (msgsArray.isNotEmpty) {
        var index = Random().nextInt(msgsArray.length);
        Message msg = msgsArray[index];
        await ctrl.deleteMessage(msg, index);
        setState(() {
          var size = ctrl.messages.length;
          message = "Mensaje Eliminado [$size]";
        });
      } else {
        setState(() {
          message = "No hay mensajes";
        });
      }
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
      body: Obx(() {
        return ListView.builder(
          // the number of items in the list
          itemCount: ctrl.messages.length,
          // display each item of the product list
          itemBuilder: (context, index) {
            return Card(
              // In many cases, the key isn't mandatory
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      ctrl.messages[index].mail,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(ctrl.messages[index].text),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: createMessage,
            tooltip: 'Crear Mensaje',
            child: const Icon(Icons.message),
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton(
            onPressed: updateMessage,
            tooltip: 'Actualizar Mensaje',
            child: const Icon(Icons.message_outlined),
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton(
            onPressed: deleteMessage,
            tooltip: 'Eliminar Mensaje',
            child: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
