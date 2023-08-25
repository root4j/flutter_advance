import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/my_camera_controller.dart';

class PreviewWidget extends StatefulWidget {
  const PreviewWidget({super.key});

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  // Controladores
  MyCameraController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        if (ctrl.path.isNotEmpty) {
          return Image.file(File(ctrl.path));
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }
}
