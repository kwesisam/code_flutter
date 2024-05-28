import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pils_recommendation/models/userinfor.dart';

class Database {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String firstname, String lastname, String email,
      String patientID, String uid) async {
    UserInformation userInformation = UserInformation(
        firstname: firstname,
        lastname: lastname,
        email: email,
        id: uid,
        patientId: patientID);
    await users.doc(uid).set(userInformation.toFirebase());
  }

  Future getUserData(String uid) async {
    return await users.doc(uid).get();
  }

  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patient');

  Future getPatientData(String id) async {
    return await patientCollection.doc(id).collection('medications').get();
  }

  Future<void> deleteMedicationByData(data) async {
    QuerySnapshot querySnapshot = await patientCollection
        .doc(data['patientId'])
        .collection('medications')
        .where('medication', isEqualTo: data['medication'])
        .get();

    querySnapshot.docs.forEach((doc) async {
      if (doc['createdAt'] == data['createdAt'] &&
          doc['dosage'] == data['dosage'] &&
          doc['hospitalId'] == data['hospitalId'] &&
          doc['patientId'] == data['patientId'] &&
          doc['morningTime'] == data['morningTime'] &&
          doc['description'] == data['description'] &&
          doc['eveningTime'] == data['eveningTime'] &&
          doc['medication'] == data['medication'] &&
          doc['id'] == data['id'] &&
          doc['afternoonTime'] == data['afternoonTime'] &&
          doc['status'] == data['status']) {
        await doc.reference.delete();
      }
    });
  }
}
