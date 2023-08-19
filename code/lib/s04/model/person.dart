import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  // Atributos
  String id;
  String name;
  String email;
  String phone;
  String address;
  // Campos de Auditoria
  late String user;
  late Timestamp date;
  // Campo referencia a Firestore
  late DocumentReference ref;
  // Contructor
  Person(this.id, this.name, this.email, this.phone, this.address);

  Person.fromMap(Map<dynamic, dynamic> map, {required this.ref})
      : assert(map['id'] != null),
        assert(map['name'] != null),
        assert(map['email'] != null),
        assert(map['phone'] != null),
        assert(map['address'] != null),
        id = map['id'],
        name = map['name'],
        email = map['email'],
        phone = map['phone'],
        address = map['address'],
        user = map['user'] ?? "system@mail.co",
        date = map['date'] ?? Timestamp.now();

  Person.fromSnapshot(DocumentSnapshot snap)
      : this.fromMap(snap.data() as Map<dynamic, dynamic>, ref: snap.reference);

  toJson(String? user) {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'user': user ?? "system@mail.co",
      'date': Timestamp.now(),
    };
  }
}