import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/auth_controller.dart';
import 'controller/messages_nice_controller.dart';
import 'ui/firebase_central_page.dart';

class FirebaseRealtimeVisual extends StatelessWidget {
  const FirebaseRealtimeVisual({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Inyectar Controladores Get
    Get.put(AuthController());
    Get.put(MessagesNiceController());

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirebaseCentralPage(),
    );
  }
}
