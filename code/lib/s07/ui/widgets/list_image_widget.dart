import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/my_storage_controller.dart';

class ListImageWidget extends StatefulWidget {
  const ListImageWidget({super.key});

  @override
  State<ListImageWidget> createState() => _ListImageWidgetState();
}

class _ListImageWidgetState extends State<ListImageWidget> {
  // Controladores
  MyStorageController myCtrl = Get.find();

  // Iniciar los metodos del controlador
  @override
  void initState() {
    super.initState();
    myCtrl.start();
  }

  Future<void> _openImage(Reference ref) async {
    var uri = await ref.getDownloadURL();
    final Uri url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      logError('Could not launch $url');
    }
  }

  Widget _image(Reference img) {
    return FutureBuilder<String>(
      future: img.getDownloadURL(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.network(snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Widget para mostrar informacion de la informacion de las imagenes
  Widget _imageCard(Reference img) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Nombre:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(img.name),
            _image(img),
          ],
        ),
      ),
    );
  }

  // Metodo para listar las imagenes
  Widget _imageList() {
    return GetX<MyStorageController>(
      builder: ((controller) {
        if (myCtrl.images.isNotEmpty) {
          return ListView.builder(
            itemCount: myCtrl.images.length,
            itemBuilder: ((context, index) {
              var img = myCtrl.images[index];
              return GestureDetector(
                onDoubleTap: () {
                  _openImage(img);
                },
                child: _imageCard(img),
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
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: _imageList(),
        ),
      ],
    );
  }
}
