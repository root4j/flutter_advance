import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../s04/common/util.dart';
import '../../s05/domain/geo_controller.dart';
import '../data/my_location.dart';
import '../domain/my_location_controller.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  // Controladores
  GeoController geoCtrl = Get.find();
  MyLocationController myCtrl = Get.find();
  // Utilidades
  Util util = Util();

  void _getCurrentPosition() async {
    try {
      var status = await geoCtrl.getStatusGPSPermission();
      if (!status.isGranted) {
        status = await geoCtrl.requestGPSPermission();
      }
      if (status.isGranted) {
        var p = await geoCtrl.getCurrentPosition();
        var loc = MyLocation(p.latitude, p.longitude, p.altitude);
        myCtrl.addLocation(loc);
        util.showInfo("Posicion", "Localizacion creada exitosamente!");
      } else {
        util.showError("Posicion", "Estas perdido, nada que hacer!");
      }
    } catch (e) {
      util.showError("Error", "Error: $e");
    }
  }

  // Iniciar los metodos del controlador
  @override
  void initState() {
    super.initState();
    myCtrl.start();
  }

  // Detener los metodos del controlador
  @override
  void dispose() {
    myCtrl.stop();
    super.dispose();
  }

  void _openSettings() async {
    var status = await geoCtrl.getStatusGPSPermission();
    if (status.isPermanentlyDenied || status.isDenied) {
      openAppSettings();
    }
  }

  Future<void> _openMap(double lat, double lon) async {
    final Uri url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      util.showError("Error", 'Could not launch $url');
    }
  }

  // Widget para mostrar informacion de la posicion
  Widget _locationCard(MyLocation loc) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Linea de Fecha
            Row(
              children: [
                const Text(
                  "Fecha:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(DateFormat('MM/dd/yyyy, hh:mm a')
                    .format(loc.creationDate.toDate())),
              ],
            ),
            // Linea de Latitud
            Row(
              children: [
                const Text(
                  "Latitud:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(loc.latitude.toString()),
              ],
            ),
            // Linea de Longitud
            Row(
              children: [
                const Text(
                  "Longitud:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(loc.longitude.toString()),
              ],
            ),
            // Linea de Altitud
            Row(
              children: [
                const Text(
                  "Altitud:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(loc.altitude.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Metodo para listar las localizaciones
  Widget _locationList() {
    return GetX<MyLocationController>(
      builder: ((controller) {
        if (myCtrl.locations.isNotEmpty) {
          // Ordenar listado
          myCtrl.locations
              .sort((((a, b) => b.creationDate.compareTo(a.creationDate))));
          return ListView.builder(
            itemCount: myCtrl.locations.length,
            itemBuilder: ((context, index) {
              var loc = myCtrl.locations[index];
              return GestureDetector(
                onDoubleTap: () {
                  _openMap(loc.latitude, loc.longitude);
                },
                child: _locationCard(loc),
              );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geo Firestore"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: _locationList(),
          ),
        ],
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _getCurrentPosition,
            child: const Icon(Icons.gps_fixed),
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton(
            onPressed: _openSettings,
            child: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
