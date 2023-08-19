import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../controller/authentication_controller.dart';
import 'person_form_widget.dart';
import 'person_list_widget.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  // Variables
  int _index = 0;
  // Listado de Widgets
  final List<Widget> _widgets = <Widget>[
    const PersonListWidget(),
    const PersonFormWidget(),
  ];
  // Controladores
  AuthenticationController ctrl = Get.find();

  // Metodo para cerrar sesion
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
      body: _widgets.elementAt(_index),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_search,
            ),
            label: "Listado",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add,
            ),
            label: "Agregar",
          ),
        ],
        currentIndex: _index,
        selectedItemColor: Colors.blue,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
    );
  }
}
