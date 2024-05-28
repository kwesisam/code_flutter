import 'package:cloud_firestore/cloud_firestore.dart';

class Prescribtion {
  String id;
  String patientId;
  String mediation;
  String dosage;
  String morningTime;
  String afternoonTime;
  String eveningTime;
  String description;
  String status;
  String hospitalId;
  Timestamp createdAt;
  Prescribtion(
      {required this.id,
      required this.patientId,
      required this.mediation,
      required this.dosage,
      required this.hospitalId,
      required this.morningTime,
      required this.afternoonTime,
      required this.eveningTime,
      required this.description,
      required this.status,
      required this.createdAt});

  factory Prescribtion.fromFirebase(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    dynamic data = snapshot.data();
    return Prescribtion(
        id: data['id'],
        patientId: data['patientId'],
        mediation: data['mediation'],
        dosage: data['dosage'],
        morningTime: data['morningTime'],
        afternoonTime: data['afternoonTime'],
        eveningTime: data['eveningTime'],
        description: data['description'],
        status: data['status'],
        hospitalId: data['hospitalId'],
        createdAt: data['createdAt']);
  }
}
