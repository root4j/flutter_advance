import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLoginBasic extends StatelessWidget {
  const FirebaseLoginBasic({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Firebase Auth Basico'),
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
  // Variables
  final String _user = "rjay@mail.co";
  final String _pswd = "Aq7&84wPSaf&rdP22yA3";
  String message = "";

  void createUser(bool isCorrect) async {
    var msg = "Usuario Creado!";
    try {
      if (isCorrect) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _user, password: _pswd);
      } else {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _user, password: "abc");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        msg = "La contraseña no cumple con los requisitos minimos!";
      } else if (e.code == "email-already-in-use") {
        msg = "El usuario ya se encuentra registrado!";
      } else {
        msg = "Error desconocido de Firebase ${e.code}!";
      }
    } catch (e) {
      msg = "Error en plataforma: $e";
    }
    setState(() {
      message = msg;
    });
  }

  void loginUser(bool isCorrect) async {
    var msg = "Usuario Autenticado!";
    try {
      if (isCorrect) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _user, password: _pswd);
      } else {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _user, password: "abc");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        msg = "El usuario no se encuentra registrado!";
      } else if (e.code == "wrong-password") {
        msg = "Contraseña incorrecta!";
      } else {
        msg = "Error desconocido de Firebase ${e.code}!";
      }
    } catch (e) {
      msg = "Error en plataforma: $e";
    }
    setState(() {
      message = msg;
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
            Text(
              message,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              createUser(true);
            },
            tooltip: 'Agregar Usuario',
            child: const Icon(Icons.supervised_user_circle),
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton(
            onPressed: () {
              createUser(false);
            },
            tooltip: 'Agregar Usuario Incorrecto',
            child: const Icon(Icons.supervised_user_circle_outlined),
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton(
            onPressed: () {
              loginUser(true);
            },
            tooltip: 'Login Usuario Correcto',
            child: const Icon(Icons.login),
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton(
            onPressed: () {
              loginUser(false);
            },
            tooltip: 'Login Usuario Incorrecto',
            child: const Icon(Icons.login_sharp),
          ),
        ],
      ),
    );
  }
}
