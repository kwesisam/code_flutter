import 'package:flutter/material.dart';
import 'package:pils/pages/logins/signin.dart';
import 'package:pils/pages/logins/signup.dart';

class SignOn extends StatefulWidget {
  const SignOn({super.key});

  @override
  State<SignOn> createState() => _SignOnState();
}

class _SignOnState extends State<SignOn> {
  bool isLogin = true;
  void toggleLogin() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return SignIn(toggleLogin: toggleLogin);
    } else {
      return SignUp(toggleLogin: toggleLogin);
    }
  }
}
