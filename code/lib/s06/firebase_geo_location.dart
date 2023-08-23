import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../s05/domain/geo_controller.dart';
import 'domain/my_location_controller.dart';
import 'ui/content_widget.dart';

class FirebaseGeoLocation extends StatelessWidget {
  const FirebaseGeoLocation({super.key});

  @override
  Widget build(BuildContext context) {
    // Inyectar Controladores Get
    Get.put(GeoController());
    Get.put(MyLocationController());

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ContentWidget(),
    );
  }
}