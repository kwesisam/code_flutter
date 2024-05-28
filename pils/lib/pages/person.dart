import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pils/services/database.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  TextEditingController idController = TextEditingController();
  TextEditingController medicationController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController morningTimeController = TextEditingController();
  TextEditingController afternoonTimeController = TextEditingController();
  TextEditingController eveningTimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Add Medication',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: idController,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ID is required';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: medicationController,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      labelText: 'Medication',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Medication is required';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: dosageController,
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      labelText: 'Dosage',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Dosage is required';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: morningTimeController,
                    decoration: InputDecoration(
                      labelText: 'Morning Time',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(
                          FocusNode()); // to prevent opening the onscreen keyboard
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        morningTimeController.text = pickedTime.format(
                            context); // format the picked time and assign to the controller
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Time is required';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: afternoonTimeController,
                    decoration: InputDecoration(
                      labelText: 'Afternoon Time',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(
                          FocusNode()); // to prevent opening the onscreen keyboard
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        afternoonTimeController.text = pickedTime.format(
                            context); // format the picked time and assign to the controller
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Time is required';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: eveningTimeController,
                    decoration: InputDecoration(
                      labelText: 'Evening Time',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(
                          FocusNode()); // to prevent opening the onscreen keyboard
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        eveningTimeController.text = pickedTime.format(
                            context); // format the picked time and assign to the controller
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Time is required';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description is required';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      //print(TimeOfDay.now().format(context).toString());

                      if (formkey.currentState!.validate()) {
                        print('Validated');
                        await DatabaseService().addPatient(
                          idController.text,
                          FirebaseAuth.instance.currentUser!.uid,
                          medicationController.text,
                          dosageController.text,
                          morningTimeController.text,
                          afternoonTimeController.text,
                          eveningTimeController.text,
                          descriptionController.text,
                          'not finished',
                          idController.text,
                        );
                        idController.clear();
                        medicationController.clear();
                        dosageController.clear();
                        morningTimeController.clear();
                        afternoonTimeController.clear();
                        eveningTimeController.clear();
                        descriptionController.clear();
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
