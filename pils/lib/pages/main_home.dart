import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pils/services/database.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final _db = DatabaseService();
  void initState() {
    super.initState();
    //getAMedication();
    //getPatientData();
  }

  List<Map<String, dynamic>> dataList = [];

  void getAMedication(id) async {
    dataList.clear();
    QuerySnapshot querySnapshot = await _db.getPatientData(id);
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    for (var doc in docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      dataList.add(data);
    }
    setState(() {});

    print(dataList.length);
  }

  /*void getPatientData() async {
    int count = await _db.getAllPatientCount();
    print(count);
  }*/
  final formkey = GlobalKey<FormState>();
  TextEditingController patientID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Expanded(child: DashboardIno())],
      ),
    );
  }

  Widget Dashboard() {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              const Center(
                  child: Text('Dashboard', style: TextStyle(fontSize: 20))),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Total Patients'),
                              subtitle: Text('100'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Total Prescriptions'),
                              subtitle: Text('100'),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Total Doctors'),
                              subtitle: Text('100'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Total Appointments'),
                              subtitle: Text('100'),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
      ],
    );
  }

  Widget DashboardIno() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Center(
            child: Text('Search Patient Medication Record',
                style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 20),
          Form(
            key: formkey,
            child: TextFormField(
              controller: patientID,
              decoration: InputDecoration(
                isDense: true,
                border: const OutlineInputBorder(),
                hintText: 'Search Patient by ID',
                suffixIcon: GestureDetector(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      getAMedication(patientID.text);
                    }
                  },
                  child: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataList[index]['medication'] as String,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(dataList[index]['description'] as String),
                          ],
                        ),
                      ),
                      Row(children: [
                        Expanded(
                          child: ListTile(
                            title:
                                Text(dataList[index]['morningTime'] as String),
                            subtitle: const Text('Morning'),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                                dataList[index]['afternoonTime'] as String),
                            subtitle: const Text('Afternoon'),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title:
                                Text(dataList[index]['eveningTime'] as String),
                            subtitle: const Text('Evening'),
                          ),
                        ),
                      ]),
                      Row(children: [
                        Expanded(
                          child: ListTile(
                            title: Text(dataList[index]['status'] as String),
                            subtitle: const Text('Status'),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(dataList[index]['dosage'] as String),
                            subtitle: const Text('Dosage'),
                          ),
                        ),
                      ]),
                    ]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
//getAllPatients

   /*StreamBuilder<DocumentSnapshot>(
          stream:
              DatabaseService().getUser(FirebaseAuth.instance.currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // show loading spinner while waiting for data
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}'); // show error if something goes wrong
            } else {
              if (snapshot.data!.exists) {
                Map<String, dynamic> data = snapshot.data!.data()
                    as Map<String, dynamic>; // get the data from the snapshot
                return Text(
                    'Data: ${data['email']}'); // display the data from the document
              } else {
                return Text('Document does not exist');
              }
            }
          },
        )*/