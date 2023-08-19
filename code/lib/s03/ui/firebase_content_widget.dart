import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../controller/auth_controller.dart';
import 'firebase_message_widget.dart';

class FirebaseContentWidget extends StatefulWidget {
  const FirebaseContentWidget({super.key});

  @override
  State<FirebaseContentWidget> createState() => _FirebaseContentWidgetState();
}

class _FirebaseContentWidgetState extends State<FirebaseContentWidget> {
  // Controladores
  AuthController ctrl = Get.find();

  _logout() async {
    try {
      await ctrl.signOut();
    } catch (e) {
      logError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = ctrl.getMail();
    return Scaffold(
      appBar: AppBar(
        title: Text(user),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: const FirebaseMessageWidget(),
    );
  }
}
