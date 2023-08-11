import 'package:flutter/material.dart';

class WorkmanagerBasic extends StatelessWidget {
  const WorkmanagerBasic({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tarea en Segundo Plano Basico"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Demo Tarea',
              ),
            ],
          ),
        ),
      ),
    );
  }
}