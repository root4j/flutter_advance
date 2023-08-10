import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/signal_controller.dart';

class CheckSignalGet extends StatelessWidget {
  const CheckSignalGet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SignalController>(() => SignalController());
    
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Verificar Señal Get'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Obtener mi controlador de señal
  SignalController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(
              () => Text(
                ctrl.signal,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Obx(
              () => Icon(
                ctrl.icon,
                size: 45,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ctrl.checkSignalType();
        },
        tooltip: 'Verificar',
        child: const Icon(Icons.wifi),
      ),
    );
  }
}
