import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/geo_controller.dart';
import 'geo_widget.dart';

class GeoLocationBasic extends StatelessWidget {
  const GeoLocationBasic({super.key});

  @override
  Widget build(BuildContext context) {
    // Inyectar Controladores Get
    Get.put(GeoController());

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GeoWidget(),
    );
  }
}