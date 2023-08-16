import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLoginForm extends StatelessWidget {
  const FirebaseLoginForm({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Firebase Auth'),
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
  // Controladores
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _pswdCtrl = TextEditingController();
  // Variables
  String _user = "";
  String _pswd = "";
  String message = "";

  void _showDialog(IconData icon, String title, String content) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        icon: Icon(
          icon,
          size: 45,
        ),
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void createUser() async {
    bool isCreated = true;
    String title = "Creación";
    String msg = "Usuario Creado!";
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _user, password: _pswd);
    } on FirebaseAuthException catch (e) {
      isCreated = false;
      if (e.code == "weak-password") {
        msg = "La contraseña no cumple con los requisitos minimos!";
      } else if (e.code == "email-already-in-use") {
        msg = "El usuario ya se encuentra registrado!";
      } else {
        msg = "Error desconocido de Firebase ${e.code}!";
      }
    } catch (e) {
      isCreated = false;
      msg = "Error en plataforma: $e";
    }
    if (isCreated) {
      _showDialog(Icons.verified, title, msg);
      setState(() {
        _userCtrl.clear();
        _pswdCtrl.clear();
        _user = "";
        _pswd = "";
      });
    } else {
      _showDialog(Icons.error, title, msg);
    }
  }

  void loginUser() async {
    bool isAuth = true;
    String title = "Autenticación";
    String msg = "Usuario Autenticado!";
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _user, password: _pswd);
    } on FirebaseAuthException catch (e) {
      isAuth = false;
      if (e.code == "user-not-found") {
        msg = "El usuario y/o contraseña errados!";
      } else if (e.code == "wrong-password") {
        msg = "El usuario y/o contraseña errados!";
      } else {
        msg = "Error desconocido de Firebase ${e.code}!";
      }
    } catch (e) {
      isAuth = false;
      msg = "Error en plataforma: $e";
    }
    if (isAuth) {
      _showDialog(Icons.verified, title, msg);
      setState(() {
        _userCtrl.clear();
        _pswdCtrl.clear();
        _user = "";
        _pswd = "";
      });
    } else {
      _showDialog(Icons.error, title, msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: _userCtrl,
                onChanged: (value) {
                  setState(() {
                    _user = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
                controller: _pswdCtrl,
                onChanged: (value) {
                  setState(() {
                    _pswd = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(message),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    createUser();
                  },
                  tooltip: 'Crear Usuario',
                  child: const Icon(Icons.supervised_user_circle),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    loginUser();
                  },
                  tooltip: 'Login Usuario Correcto',
                  child: const Icon(Icons.login),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
