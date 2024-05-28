import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pils/models/prescribtion.dart';
import 'package:pils/models/user_info.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('hospital');

  Future<void> addUser(String hospitalName, String email, String id) async {
    UserInfomation userInfomation = UserInfomation(
      id: id,
      hospital: hospitalName,
      email: email,
      createdAt: Timestamp.now(),
    );

    await userCollection.doc(id).set(userInfomation.toFirestore());
  }

  Future<void> updateUser(String hospitalName, String email, String id) async {
    //return await userCollection.doc(id).update(data);
  }

  Future<void> deleteUser(String id) async {
    return await userCollection.doc(id).delete();
  }

  /*Stream<QuerySnapshot> gbetUsers() {
    return userCollection.snapshots();
  }*/

  Stream<DocumentSnapshot> getUser(String id) {
    return userCollection.doc(id).snapshots();
  }

  Future getUserData(String id) async {
    return await userCollection.doc(id).get();
  }

  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patient');

  Future<void> addPatient(
      String patientID,
      String hospitalID,
      String mediation,
      String dosage,
      String morningTime,
      String afternoonTime,
      String eveningTime,
      String description,
      String status,
      String id) async {
    Prescribtion prescribtion = Prescribtion(
      id: id,
      patientId: patientID,
      hospitalId: hospitalID,
      mediation: mediation,
      dosage: dosage,
      morningTime: morningTime,
      afternoonTime: afternoonTime,
      eveningTime: eveningTime,
      description: description,
      status: status,
      createdAt: Timestamp.now(),
    );

    await patientCollection
        .doc(id)
        .collection('medications')
        .add(prescribtion.toJson());
  }

  Future<void> updatePatient(dynamic data, String id) async {
    return await patientCollection.doc(id).update(data);
  }

  Future<void> deletePatient(String id) async {
    return await patientCollection.doc(id).delete();
  }

  Stream<QuerySnapshot> getPatients(String id) {
    return patientCollection.doc(id).collection('medications').snapshots();
  }

  Stream<QuerySnapshot> getAllPatients() {
    return patientCollection.snapshots();
  }

  Future<QuerySnapshot> getAllPatientData() async {
    return await patientCollection.get();
  }

  Future<int> getAllPatientCount() async {
    QuerySnapshot snapshot = await patientCollection.get();
    return snapshot.docs.length;
  }

  Future getPatientData(String id) async {
    return await patientCollection.doc(id).collection('medications').get();
  }

  Stream<DocumentSnapshot> getPatient(String id) {
    return patientCollection.doc(id).snapshots();
  }

  Future<void> deleteMedication(String id, String medicationId) async {
    return await patientCollection
        .doc(id)
        .collection('medications')
        .doc(medicationId)
        .delete();
  }

  Future<void> updateMedication(
      String id, String medicationId, dynamic data) async {
    return await patientCollection
        .doc(id)
        .collection('medications')
        .doc(medicationId)
        .update(data);
  }
}
