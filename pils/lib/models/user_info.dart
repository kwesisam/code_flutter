import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfomation {
  String hospital;
  String email;
  String id;
  Timestamp createdAt;
  UserInfomation(
      {required this.hospital,
      required this.email,
      required this.id,
      required this.createdAt});

  factory UserInfomation.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return UserInfomation(
      hospital: data?['hospital'],
      email: data?['email'],
      id: data?['id'],
      createdAt: data?['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'hospital': hospital,
      'email': email,
      'id': id,
      'createdAt': createdAt,
    };
  }
}
