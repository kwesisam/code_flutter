import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pils_recommendation/Pages/dev.dart';
import 'package:pils_recommendation/Pages/main_home.dart';
import 'package:pils_recommendation/Pages/services/auth.dart';
import 'package:pils_recommendation/Pages/services/database.dart';
import 'package:pils_recommendation/models/userinfor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  bool viewAddMedication = false;
  bool viewRemoveMedication = false;
  bool viewMedicationList = false;
  bool order = true;
  bool confirmOrder = false;
  bool makeOrder = false;

  final _auth = Authentication();

  void logout() {
    _auth.logOut();
  }

  void initState() {
    super.initState();
    getUser();
  }

  UserInformation? userInformation;

  void getUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print(currentUser.uid);
      final user = await Database().getUserData(currentUser.uid);

      if (user != null) {
        setState(() {
          userInformation = UserInformation.fromFirebase(user);
        });
      } else {
        print('No user data found');
      }
    } else {
      print('No current user');
    }
  }

  void changeAddVMeddiation() {
    setState(() {
      viewAddMedication = !viewAddMedication;
      viewRemoveMedication = false;
    });
  }

  void changeRemoveMedication() {
    setState(() {
      viewRemoveMedication = !viewRemoveMedication;
      viewAddMedication = false;
    });
  }

  void changeMedicationList() {
    setState(() {
      viewMedicationList = !viewMedicationList;
    });
  }

  void changeOrder() {
    setState(() {
      order = !order;
      confirmOrder = false;
      makeOrder = false;
    });
  }

  void changeConfirmOrder() {
    setState(() {
      confirmOrder = !confirmOrder;
      order = false;
      makeOrder = false;
    });
  }

  void changeMakeOrder() {
    setState(() {
      makeOrder = !makeOrder;
      confirmOrder = false;
      order = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          print(index);
          setState(() {
            currentIndex = index;
          });
          print(currentIndex);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shop_2),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2),
            label: 'Inventory',
          ),
          NavigationDestination(
            icon: Icon(Icons.store_mall_directory),
            label: 'Stocks',
          ),
        ],
      ),*/
      body: //[
          userInformation == null
              ? const SpinKitDancingSquare(
                  color: Colors.brown,
                  size: 80.0,
                )
              : MainHome(
                  viewAddMedication: viewAddMedication,
                  viewRemoveMedication: viewRemoveMedication,
                  viewMedicationList: viewMedicationList,
                  userInformation: userInformation!,
                ),
      /*Orders(
          order: order,
          makeOrder: makeOrder,
          confirmOrder: confirmOrder,
        ),
        const Inventory(),
        const Stocks(),
      ][currentIndex],()*/
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title:
            const Text('Pils Remaender', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          if (currentIndex == 0)
            PopupMenuButton<String>(
              iconColor: Colors.white,
              onSelected: (String result) {
                if (result == 'Logout') {
                  logout();
                } else if (result == 'Add Medication') {
                  changeAddVMeddiation();
                } else if (result == 'Remove Medication') {
                  changeRemoveMedication();
                } else if (result == 'View Medication List') {
                  changeMedicationList();
                } else if (result == 'Dev') {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Dev()));
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'User name',
                  child: Row(
                    children: <Widget>[
                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 10),
                      Text(userInformation != null
                          ? '${userInformation!.firstname} ${userInformation!.lastname}'
                          : 'User Name'),
                    ],
                  ),
                ),
                /*const PopupMenuItem<String>(
                    value: 'Add Medication', child: Text('Add Medication')),
                const PopupMenuItem<String>(
                    value: 'Remove Medication',
                    child: Text('Remove Medication')),
                const PopupMenuItem<String>(
                    value: 'View Medication List',
                    child: Text('View Medication List')),*/
                const PopupMenuItem<String>(
                    value: 'Settings',
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.settings),
                        SizedBox(width: 10),
                        Text('Settings'),
                      ],
                    )),
                const PopupMenuItem<String>(
                  value: 'Dev',
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.developer_mode),
                      SizedBox(width: 10),
                      Text('Developers'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
            ),
          if (currentIndex == 1)
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Logout') {
                  // Handle logout logic here
                  logout();
                } else if (result == 'Order') {
                  changeOrder();
                } else if (result == 'Confirm Order') {
                  changeConfirmOrder();
                } else if (result == 'Make Order') {
                  changeMakeOrder();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                    value: 'Order', child: Text('Orders')),
                const PopupMenuItem<String>(
                    value: 'Make Order', child: Text('Make Order')),
                const PopupMenuItem<String>(
                    value: 'Confirm Order', child: Text('Confirm Order')),
                const PopupMenuItem<String>(
                  value: 'User name',
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(),
                      SizedBox(width: 8),
                      Text('User Name'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Settings',
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.settings),
                      SizedBox(width: 8),
                      Text('Settings'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
            ),
          if (currentIndex == 2)
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Logout') {
                  // Handle logout logic here
                  logout();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                    value: 'User name', child: Text('Inventory')),
                const PopupMenuItem<String>(
                  value: 'User name',
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(),
                      SizedBox(width: 8),
                      Text('User Name'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Settings',
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.settings),
                      SizedBox(width: 8),
                      Text('Settings'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
            ),
          if (currentIndex == 3)
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Logout') {
                  // Handle logout logic here
                  logout();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                    value: 'User name', child: Text('Stocks')),
                const PopupMenuItem<String>(
                  value: 'User name',
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(),
                      SizedBox(width: 8),
                      Text('User Name'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Settings',
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.settings),
                      SizedBox(width: 8),
                      Text('Settings'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
