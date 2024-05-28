import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation {
  final String firstname;
  final String lastname;
  final String patientId;
  final String email;
  final String id;

  UserInformation({
    required this.firstname,
    required this.lastname,
    required this.id,
    required this.patientId,
    required this.email,
  });

  factory UserInformation.fromFirebase(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserInformation(
      firstname: data?['firstname'],
      lastname: data?['lastname'],
      patientId: data?['patientId'],
      email: data?['email'],
      id: data?['id'],
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'id': id,
      'patientId': patientId,
      'email': email,
    };
  }
}
