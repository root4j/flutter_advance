import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/util.dart';
import '../../controller/authentication_controller.dart';
import '../../controller/person_controller.dart';
import '../../model/person.dart';

class PersonFormWidget extends StatefulWidget {
  const PersonFormWidget({super.key});

  @override
  State<PersonFormWidget> createState() => _PersonFormWidgetState();
}

class _PersonFormWidgetState extends State<PersonFormWidget> {
  // Obtener Controladores
  AuthenticationController aCtrl = Get.find();
  PersonController pCtrl = Get.find();
  // Controlador de Widgets
  final TextEditingController _idCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _mailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  // Utilidades
  Util util = Util();

  // Metodo de Agregar usuario
  _addPerson() async {
    try {
      if (_idCtrl.text.isEmpty ||
          _nameCtrl.text.isEmpty ||
          _mailCtrl.text.isEmpty ||
          _phoneCtrl.text.isEmpty ||
          _addressCtrl.text.isEmpty) {
        util.showError(
            "Validación", "Todos los campos deben ser diligenciados!");
      } else {
        var person = Person(_idCtrl.text, _nameCtrl.text, _mailCtrl.text,
            _phoneCtrl.text, _addressCtrl.text);
        await pCtrl.addPerson(person, aCtrl.getMail());
        util.showInfo("Creación", "Persona creada exitosamente!");
        _idCtrl.clear();
        _nameCtrl.clear();
        _mailCtrl.clear();
        _phoneCtrl.clear();
        _addressCtrl.clear();
      }
    } catch (e) {
      util.showError("Error ", "Error $e");
    }
  }

  // Metodo para iniciar los listeners
  @override
  void initState() {
    super.initState();
    pCtrl.start();
  }

  // Metodo para detener los listeners
  @override
  void dispose() {
    pCtrl.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: ListView(
            children: [
              // Documento
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Documento:',
                  ),
                  controller: _idCtrl,
                ),
              ),
              // Nombre
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre:',
                  ),
                  controller: _nameCtrl,
                ),
              ),
              // Email
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email:',
                  ),
                  controller: _mailCtrl,
                ),
              ),
              // Telefono
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Telefono:',
                  ),
                  controller: _phoneCtrl,
                ),
              ),
              // Direccion
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Dirección:',
                  ),
                  controller: _addressCtrl,
                ),
              ),
              // Direccion
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextButton(
                  onPressed: _addPerson,
                  child: const Text("Agregar Persona"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
