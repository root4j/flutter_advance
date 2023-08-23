import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../s04/common/util.dart';
import '../domain/geo_controller.dart';

class GeoWidget extends StatefulWidget {
  const GeoWidget({super.key});

  @override
  State<GeoWidget> createState() => _GeoWidgetState();
}

class _GeoWidgetState extends State<GeoWidget> {
  // Controladores
  GeoController ctrl = Get.find();
  // Utilidades
  Util util = Util();

  void _getCurrentPosition() async {
    try {
      var status = await ctrl.getStatusGPSPermission();
      if (!status.isGranted) {
        status = await ctrl.requestGPSPermission();
      }
      if (status.isGranted) {
        var position = await ctrl.getCurrentPosition();
        var lat = position.latitude;
        var lon = position.longitude;
        util.showInfo("Posicion", "{latitud: $lat, longitud: $lon}");
      } else {
        util.showError("Posicion", "Estas perdido, nada que hacer!");
      }
    } catch (e) {
      util.showError("Error", "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geo Localizacion Demo"),
      ),
      body: const Center(
        child: Text("Geo Demo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentPosition,
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
