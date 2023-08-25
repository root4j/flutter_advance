import 'package:firebase_database/firebase_database.dart';

class Message {
  // Atributos
  String? key;
  String mail;
  String text;

  // Contructor inicial
  Message(this.mail, this.text);

  // Obtener Datos de Firebase Realtime Database
  Message.fromJSON(DataSnapshot snapshot, Map<dynamic, dynamic> json)
      : key = snapshot.key ?? '0',
        mail = json['mail'] ?? 'not@found.mail',
        text = json['text'] ?? 'No Text';

  // Metodo de Conversion
  toJSON() {
    return {"mail": mail, "text": text};
  }
}
