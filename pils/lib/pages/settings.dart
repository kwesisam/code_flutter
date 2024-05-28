import 'package:flutter/material.dart';
import 'package:pils/models/user_info.dart';
import 'package:pils/services/auth.dart';

class Settings extends StatefulWidget {
  final UserInfomation userInfomation;
  const Settings({super.key, required this.userInfomation});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _auth = AuthenticationService();

  void initState() {
    super.initState();
    //getUserData();
  }

  /*void getUserData() async {
    final user = await _db.getUserData(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      userInfomation = UserInfomation.fromFirestore(user);
      dataNo = false;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                      ),
                      title: Text(widget.userInfomation.hospital),
                      subtitle: Text(widget.userInfomation.email),
                    )
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    _auth.logOut();
                  },
                  child: const Center(child: Text('Sign Out')))
            ],
          ),
        ),
      ),
    );
  }
}
