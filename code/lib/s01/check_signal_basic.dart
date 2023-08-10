import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CheckSignalBasic extends StatelessWidget {
  const CheckSignalBasic({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Verficar Señal Basico'),
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
  // Variable donde se almacena el estado de red
  String _signal = "";

  // Funcion que retorna el tipo de señal en el instante
  Future<ConnectivityResult> _getSignalType() {
    return Connectivity().checkConnectivity();
  }

  void _checkSignal() async {
    // Llamar nuestro futuro
    var cr = await _getSignalType();
    // Cambio de estado
    setState(() {
      if (cr == ConnectivityResult.wifi) {
        _signal = "Wifi";
      } else if (cr == ConnectivityResult.mobile) {
        _signal = "Movil";
      } else {
        _signal = "Sin Red";
      }
    });
  }

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
            const Text(
              'Estado de Red es:',
            ),
            Text(
              _signal,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkSignal,
        tooltip: 'Verificar',
        child: const Icon(Icons.wifi),
      ),
    );
  }
}
