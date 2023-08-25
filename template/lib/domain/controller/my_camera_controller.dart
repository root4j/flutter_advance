import 'package:camera/camera.dart';
import 'package:get/get.dart';

class MyCameraController extends GetxController {
  // Variable Observables
  final Rx<CameraDescription> _camera;
  late Rx<CameraController> _controller;
  final _path = "".obs;
  final _initCamera = false.obs;

  // Getters
  CameraDescription get camera => _camera.value;
  CameraController get controller => _controller.value;
  String get path => _path.value;
  bool get initCamera => _initCamera.value;

  // Setters
  set controller(CameraController value) {
    _controller = Rx<CameraController>(value);
  }

  set path(String value) {
    _path.value = value;
  }

  set initCamera(bool value) {
    _initCamera.value = value;
  }

  // Constructor
  MyCameraController(CameraDescription value)
      : _camera = Rx<CameraDescription>(value);
}
