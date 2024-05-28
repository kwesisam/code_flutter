import 'package:flutter/material.dart';
import 'package:pils_recommendation/Pages/logins/siginin.dart';
import 'package:pils_recommendation/Pages/logins/signup.dart';

class SignOn extends StatefulWidget {
  const SignOn({super.key});

  @override
  State<SignOn> createState() => _SignOnState();
}

class _SignOnState extends State<SignOn> {
  bool toLogin = true;
  void toggleLogin() {
    print(toLogin);
    setState(() {
      toLogin = !toLogin;
    });
    print(toLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (toLogin) {
      return SignIn(
        toggleLogin: toggleLogin,
      );
    } else {
      return SignUp(
        toggleLogin: toggleLogin,
      );
    }
  }
}
