import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  // Metodo para crear usuarios en Firebase
  Future createUser(String user, String pswd) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: pswd);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return Future.error(
            "La contraseña no cumple con los requisitos minimos!");
      } else if (e.code == "email-already-in-use") {
        return Future.error("El usuario ya se encuentra registrado!");
      } else {
        return Future.error("Error desconocido de Firebase ${e.code}!");
      }
    } catch (e) {
      return Future.error("Error en plataforma: $e");
    }
  }

  // Metodo para autenticar usuarios en Firebase
  Future loginUser(String user, String pswd) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: pswd);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return Future.error("El usuario y/o contraseña errados!");
      } else if (e.code == "wrong-password") {
        return Future.error("El usuario y/o contraseña errados!");
      } else {
        return Future.error("Error desconocido de Firebase ${e.code}!");
      }
    } catch (e) {
      return Future.error("Error en plataforma: $e");
    }
  }

  // Metodo para cerrar sesion
  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error("Error en plataforma: $e");
    }
  }

  // Metodo para obtener el email del usuario conectado
  String getMail() {
    return FirebaseAuth.instance.currentUser!.email ?? 'not@found.mail';
  }
}
