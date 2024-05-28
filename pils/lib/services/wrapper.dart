import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pils/pages/home.dart';
import 'package:pils/pages/logins/signon.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final User? user = context.watch<User?>();
    if (user == null) {
      return const SignOn();
    } else {
      return Home(
        user: user,
      );
    }
  }
}
