import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/authentication_controller.dart';
import '../../controller/person_controller.dart';
import '../../model/person.dart';

class PersonListWidget extends StatefulWidget {
  const PersonListWidget({super.key});

  @override
  State<PersonListWidget> createState() => _PersonListWidgetState();
}

class _PersonListWidgetState extends State<PersonListWidget> {
  // Obtener Controladores
  AuthenticationController aCtrl = Get.find();
  PersonController pCtrl = Get.find();
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

  // Widget para mostrar informacion de la persona
  Widget _personCard(Person person) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Linea de nombre
            Row(
              children: [
                const Text(
                  "Nombre:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(person.name),
              ],
            ),
            // Linea de Email
            Row(
              children: [
                const Text(
                  "Email:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(person.email),
              ],
            ),
            // Linea de Email
            Row(
              children: [
                const Text(
                  "Dirección:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(person.address),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Metodo para listar las personas
  Widget _personList() {
    return GetX<PersonController>(
      builder: ((controller) {
        if (pCtrl.persons.isNotEmpty) {
          // Ordenar listado
          pCtrl.persons.sort((((a, b) => a.date.compareTo(b.date))));
          return ListView.builder(
            itemCount: pCtrl.persons.length,
            //controller: _scrollCtrl,
            itemBuilder: ((context, index) {
              var per = pCtrl.persons[index];
              return _personCard(per);
            }),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: _personList(),
        ),
      ],
    );
  }
}
