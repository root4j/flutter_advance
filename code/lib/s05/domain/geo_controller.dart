import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// Controlador de Posicion
class GeoController extends GetxController {
  // Posicion Actual del Dispositivo
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  // Obtener el permiso de GPS
  Future<PermissionStatus> requestGPSPermission() async {
    var status = await Permission.location.request();
    return Future.value(status);
  }

  // Verificar estado del permiso al GPS
  Future<PermissionStatus> getStatusGPSPermission() async {
    var status = await Permission.location.status;
    return Future.value(status);
  }

  // Verificar el estado del sensor
  Future<bool> statusGPSPermission() async {
    try {
      var status = await Permission.location.status;
      return Future.value(status.isGranted);
    } catch (e) {
      return Future.value(false);
    }
  }
}
