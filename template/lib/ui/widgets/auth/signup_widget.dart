import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/common/util.dart';
import '../../../domain/controller/authentication_controller.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  // Inyectar el controlador de Autenticacion
  AuthenticationController ctrl = Get.find();
  // Controladores para las cajas de texto
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _pswdCtrl = TextEditingController();
  // Utilidades
  Util util = Util();

  void _createUser() async {
    try {
      await ctrl.createUser(_userCtrl.text, _pswdCtrl.text);
      util.showInfo("Creación", "Usuario creado!");
      _userCtrl.clear();
      _pswdCtrl.clear();
    } catch (e) {
      util.showError("Creación", "Error en plataforma: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email:",
                  ),
                  controller: _userCtrl,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Contraseña:",
                  ),
                  controller: _pswdCtrl,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: _createUser,
                child: const Text('Crear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
