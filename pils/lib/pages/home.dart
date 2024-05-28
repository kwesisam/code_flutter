import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pils/models/user_info.dart';
import 'package:pils/pages/main_home.dart';
import 'package:pils/pages/person.dart';
import 'package:pils/pages/settings.dart';
import 'package:pils/services/database.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserInfomation? userInfomation;
  final _db = DatabaseService();

  int currentIndex = 0;
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    final user = await _db.getUserData(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      userInfomation = UserInfomation.fromFirestore(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pils Remainder',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 194, 79, 37),
      ),
      body: userInfomation == null
          ? const Center(child: CircularProgressIndicator())
          : [
              const MainHome(),
              const Person(),
              Settings(
                userInfomation: userInfomation!,
              ),
            ][currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_add),
            label: 'Patient',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings), // Icon(Icons.settings
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
