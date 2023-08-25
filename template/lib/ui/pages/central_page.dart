import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/auth/login_widget.dart';
import '../widgets/content_widget.dart';

class CentralPage extends StatelessWidget {
  const CentralPage({super.key});
  // Logica para redirigir contenido autenticado
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const ContentWidget();
        } else {
          return const LoginWidget();
        }
      },
    );
  }
}