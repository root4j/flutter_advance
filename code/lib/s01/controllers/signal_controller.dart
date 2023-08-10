import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

// Clase controladora de la señal
class SignalController extends GetxController {
  // Variables
  final _signal = "".obs;
  final _icon = Icons.access_alarm_sharp.obs;

  // Getters
  String get signal => _signal.value;
  IconData get icon => _icon.value;

  // Metodos
  void checkSignalType() async {
    try {
      var cr = await Connectivity().checkConnectivity();
      switch (cr) {
        case ConnectivityResult.wifi:
          _signal.value = "Wifi";
          _icon.value = Icons.network_wifi;
          break;
        case ConnectivityResult.mobile:
          _signal.value = "Movil";
          _icon.value = Icons.network_cell;
          break;
        default:
          _signal.value = "Sin Señal";
          _icon.value = Icons.airplanemode_active;
          break;
      }
    } catch (e) {
      _signal.value = "Error $e.toString()";
      _icon.value = Icons.access_alarm_sharp;
    }
  }
}
