import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_content_widget.dart';
import 'firebase_login_widget.dart';

class FirebaseCentralPage extends StatelessWidget {
  const FirebaseCentralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const FirebaseContentWidget();
        } else {
          return const FirebaseLoginWidget();
        }
      },
    );
  }
}
