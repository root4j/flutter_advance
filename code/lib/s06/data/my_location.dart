import 'package:cloud_firestore/cloud_firestore.dart';

class MyLocation {
  // Atributos
  double latitude;
  double longitude;
  double altitude;
  // Auditoria
  late Timestamp creationDate;
  // Documento de Firestore
  late DocumentReference reference;

  // Constructor
  MyLocation(this.latitude, this.longitude, this.altitude);

  MyLocation.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map["latitude"] != null),
        assert(map["longitude"] != null),
        assert(map["altitude"] != null),
        latitude = map["latitude"],
        longitude = map["longitude"],
        altitude = map["altitude"],
        creationDate = map["creationDate"] ?? Timestamp.now();

  MyLocation.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'creationDate': Timestamp.now(),      
    };
  }
}
