import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pils_recommendation/Pages/services/database.dart';
import 'package:pils_recommendation/models/userinfor.dart';

class MainHome extends StatefulWidget {
  final bool viewAddMedication;
  final bool viewRemoveMedication;
  final bool viewMedicationList;
  final UserInformation userInformation;

  const MainHome(
      {super.key,
      required this.viewAddMedication,
      required this.viewRemoveMedication,
      required this.viewMedicationList,
      required this.userInformation});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    getMedication();
  }

  Future<void> getMedication() async {
    getAMedication(widget.userInformation.patientId);
    _timer =
        Timer.periodic(const Duration(minutes: 1), (Timer t) => yourFunction());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> showSnackBar(
      BuildContext context, String message, dynamic data) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(message, style: const TextStyle(fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () async {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () async {
                      await Database().deleteMedicationByData(data);
                      await getMedication();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 10),
    ));
  }

  void yourFunction() {
    // Your code here
    for (int i = 0; i < 1; i++) {
      if ((upCommingListHours[i]['mapm'] == 'PM'
              ? (TimeOfDay.now().hour ==
                  int.parse(upCommingListHours[i]['mhour']) + 12)
              : (TimeOfDay.now().hour ==
                  int.parse(upCommingListHours[i]['mhour']))) &&
          TimeOfDay.now().minute == int.parse(upCommingListHours[i]['mmin'])) {
        triggerNotification(
            'Medication: ${dataList[i]['medication']} Dosage: ${dataList[i]['dosage']}');
      } else if ((upCommingListHours[i]['aapm'] == 'PM'
              ? (TimeOfDay.now().hour ==
                  int.parse(upCommingListHours[i]['ahour']) + 12)
              : (TimeOfDay.now().hour ==
                  int.parse(upCommingListHours[i]['ahour']))) &&
          TimeOfDay.now().minute == int.parse(upCommingListHours[i]['amin'])) {
        triggerNotification(
            'Medication: ${dataList[i]['medication']} Dosage: ${dataList[i]['dosage']}');
      } else if ((upCommingListHours[i]['eapm'] == 'PM'
              ? (TimeOfDay.now().hour ==
                  int.parse(upCommingListHours[i]['ehour']) + 12)
              : (TimeOfDay.now().hour ==
                  int.parse(upCommingListHours[i]['ehour']))) &&
          TimeOfDay.now().minute == int.parse(upCommingListHours[i]['emin'])) {
        triggerNotification(
            'Medication: ${dataList[i]['medication']} Dosage: ${dataList[i]['dosage']}');
      } else {}
    }
  }

  void triggerNotification(String message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'It is time for your medication!',
          body: message,
          wakeUpScreen: true,
          summary: 'Message from Pils Remainder'),
    );
  }

  /*void getUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print(currentUser.uid);
      final user = await Database().getUserData(currentUser.uid);

      if (user != null) {
        setState(() {
          userInformation = UserInformation.fromFirebase(user);
        });
        if (userInformation != null) {
          getAMedication(userInformation!.patientId);
        } else {
          print('userInformation is null');
        }
      } else {
        print('No user data found');
      }
    } else {
      print('No current user');
    }
  }*/

  void deleteMedication() {}

  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> upCommingListHours = [];
  int dataListLength = 0;

  void getAMedication(id) async {
    print('hello');
    dataList.clear();
    upCommingListHours.clear();
    QuerySnapshot querySnapshot = await Database().getPatientData(id);
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    for (var doc in docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      dataList.add(data);
      String mhour = data['morningTime'].toString().split(':')[0];
      String mmin = data['morningTime'].toString().split(':')[1].split(' ')[0];
      String mapm = data['morningTime'].toString().split(':')[1].split(' ')[1];
      String ahour = data['afternoonTime'].toString().split(':')[0];
      String amin =
          data['afternoonTime'].toString().split(':')[1].split(' ')[0];
      String aapm =
          data['afternoonTime'].toString().split(':')[1].split(' ')[1];
      String ehour = data['eveningTime'].toString().split(':')[0];
      String emin = data['eveningTime'].toString().split(':')[1].split(' ')[0];
      String eapm = data['eveningTime'].toString().split(':')[1].split(' ')[1];

      upCommingListHours.add({
        'mhour': mhour,
        'mmin': mmin,
        'mapm': mapm,
        'ahour': ahour,
        'amin': amin,
        'aapm': aapm,
        'ehour': ehour,
        'emin': emin,
        'eapm': eapm,
      });
    }
    setState(() {
      dataListLength = dataList.length;
    });
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    return (dataList.isEmpty)
        ? const SpinKitDancingSquare(
            color: Colors.brown,
            size: 80.0,
          )
        : Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 3));
                getAMedication(widget.userInformation.patientId);
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Card(
                          color: Colors.white,
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.brown, width: 2),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Text('Dashboard', style: TextStyle(fontSize: 20)),
                              SizedBox(height: 10),
                              Text('Welcome to the Pils Reminder',
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.4, // or any specific height
                        child: Card(
                          color: Colors.white,
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white30, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text('Dialy Medication',
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Column(children: [
                                        const SizedBox(height: 10),
                                        Card(
                                          color: const Color.fromRGBO(
                                              239, 235, 233, 1),
                                          child: ListTile(
                                              title: Text(dataList[index]
                                                  ['medication'] as String),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                      'Time :${dataList[index]['morningTime']} | ${dataList[index]['afternoonTime']} | ${dataList[index]['eveningTime']} '),
                                                ],
                                              ),
                                              trailing: PopupMenuButton(
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  PopupMenuItem(
                                                      child: GestureDetector(
                                                    onTap: () async {
                                                      print(dataList[index]);
                                                      await showSnackBar(
                                                          context,
                                                          'Do you want to delete ${dataList[index]['medication']}?',
                                                          dataList[index]);
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Icon(Icons.delete),
                                                        SizedBox(width: 8),
                                                        Text('Delete'),
                                                      ],
                                                    ),
                                                  ))
                                                ],
                                              )),
                                        ),
                                      ]);
                                    },
                                    itemCount: dataList.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.33, // or any specific height
                        child: UpCommingAlert(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget Dashboard() {
    return Container(
      child: Column(
        children: [
          const Card(
            child: ListTile(
              title: Text('Dashboard'),
              subtitle: Text('Welcome to the Dashboard'),
            ),
          ),
          Card(
            child: Column(
              children: [
                const Center(
                  child: Text('Dialy Medication'),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (TimeOfDay.now().hour + 2 <=
                              upCommingListHours[index]['mhour'] ||
                          TimeOfDay.now().hour + 2 <=
                              upCommingListHours[index]['ahour'] ||
                          TimeOfDay.now().hour + 2 <=
                              upCommingListHours[index]['ehour']) {
                        return ListTile(
                          title: Text(dataList[index]['medication'] as String),
                        );
                      } else {
                        return Container();
                      }
                    },
                    itemCount: dataList.length,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget UpCommingAlert() {
    return Container(
      child: Card(
        color: Colors.white,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white30, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text('UpComming Medication',
                      style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if ((upCommingListHours[index]['mapm'] == 'PM'
                            ? TimeOfDay.now().hour + 2 >=
                                int.parse(upCommingListHours[index]['mhour']) +
                                    12
                            : TimeOfDay.now().hour + 2 >=
                                int.parse(
                                    upCommingListHours[index]['mhour'])) ||
                        (upCommingListHours[index]['aapm'] == 'PM'
                            ? TimeOfDay.now().hour + 2 >=
                                int.parse(upCommingListHours[index]['ahour']) +
                                    12
                            : TimeOfDay.now().hour + 2 >=
                                int.parse(
                                    upCommingListHours[index]['ahour'])) ||
                        (upCommingListHours[index]['eapm'] == 'PM'
                            ? TimeOfDay.now().hour + 2 >=
                                int.parse(upCommingListHours[index]['ehour']) +
                                    12
                            : TimeOfDay.now().hour + 2 >=
                                int.parse(
                                    upCommingListHours[index]['ehour']))) {
                      return Card(
                        color: Color.fromARGB(255, 255, 251, 249),
                        child: ListTile(
                          textColor: Colors.black87,
                          title: Text(dataList[index]['medication'] as String),
                          subtitle: Text(
                              'Time :${dataList[index]['morningTime']} | ${dataList[index]['afternoonTime']} | ${dataList[index]['eveningTime']} '),
                          /*trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      child: GestureDetector(
                                        onTap: () {
                                          
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(Icons.stop_circle_outlined),
                                            SizedBox(width: 8),
                                            Text('Stop Alert'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ])*/
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: dataList.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget AddMedication() {
    return Container(
      child: Card(
        child: Column(
          children: [
            const Center(
              child: Text('Add Medication'),
            ),
            const SizedBox(height: 10),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Medication Name',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Time',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add Medication'),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget RemoveMeddication() {
    return Container(
        child: Card(
      child: Column(
        children: [
          const Center(
            child: Text('Remove Medication'),
          ),
          const SizedBox(height: 10),
          Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Medication Name',
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Time',
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add Medication'),
              )
            ],
          ))
        ],
      ),
    ));
  }

  Widget MedicationList() {
    return Container(
      child: Card(
        child: Column(
          children: [
            const Center(
              child: Text('Medication List'),
            ),
            const SizedBox(height: 10),
            ListBody(
              children: [
                ListTile(
                  leading: const CircleAvatar(),
                  title: const Text('Medication 1'),
                  subtitle: const Text('Time: 8:00 AM'),
                  trailing: PopupMenuButton(
                      itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              child: Text('Checked'),
                            ),
                            const PopupMenuItem(
                              child: Text('Delete'),
                            ),
                          ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
