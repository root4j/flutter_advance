import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class FirebaseLoginWidget extends StatefulWidget {
  const FirebaseLoginWidget({super.key});

  @override
  State<FirebaseLoginWidget> createState() => _FirebaseLoginWidgetState();
}

class _FirebaseLoginWidgetState extends State<FirebaseLoginWidget> {
  // Controladores
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _pswdCtrl = TextEditingController();
  AuthController ctrl = Get.find();
  // Variables
  String _user = "";
  String _pswd = "";

  Future<bool> loginUser() async {
    try {
      await ctrl.loginUser(_user, _pswd);
      return Future.value(true);
    } catch (e) {
      Get.snackbar(
        "Error de Autehticación",
        "Error en plataforma: $e",
        icon: const Icon(
          Icons.person,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(
          seconds: 5,
        ),
      );
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login de Usuario"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: _userCtrl,
                onChanged: (value) {
                  setState(() {
                    _user = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
                controller: _pswdCtrl,
                onChanged: (value) {
                  setState(() {
                    _pswd = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: loginUser,
                  tooltip: 'Login Usuario Correcto',
                  child: const Icon(Icons.login),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
