import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/authentication_controller.dart';
import 'controller/person_controller.dart';
import 'ui/pages/central_page.dart';

class FirebaseFirestore extends StatelessWidget {
  const FirebaseFirestore({super.key});

  @override
  Widget build(BuildContext context) {
    // Inyectar Controladores Get
    Get.put(AuthenticationController());
    Get.put(PersonController());

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