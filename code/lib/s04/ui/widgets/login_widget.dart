import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/util.dart';
import '../../controller/authentication_controller.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  // Controladores
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _pswdCtrl = TextEditingController();
  AuthenticationController ctrl = Get.find();
  // Utilidades
  Util util = Util();
  // Variables
  String _user = "";
  String _pswd = "";

  Future<bool> loginUser() async {
    try {
      await ctrl.loginUser(_user, _pswd);
      return Future.value(true);
    } catch (e) {
      util.showError("Error de Autenticación", "Error en plataforma: $e");
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
