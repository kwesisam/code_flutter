import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/firebase_options.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _loginEmail;
  late final TextEditingController _loginPassword;

  @override
  void initState() {
    _loginEmail = TextEditingController();
    _loginPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _loginEmail.dispose();
    _loginPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Loging"),
        ),
        body: FutureBuilder(
            future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                // TODO: Handle this case.
                case ConnectionState.waiting:
                // TODO: Handle this case.
                case ConnectionState.active:
                // TODO: Handle this case.
                case ConnectionState.done:
                  return Column(
                    children: [
                      TextField(
                        controller: _loginEmail,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: "Enter your email here"),
                      ),
                      TextField(
                        controller: _loginPassword,
                        decoration: const InputDecoration(
                            hintText: "Enter your passowrd here"),
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: true,
                      ),
                      TextButton(
                          onPressed: () async {
                            final email = _loginEmail.text;
                            final password = _loginPassword.text;

                            try {
                              var userCredential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: password);

                              print(userCredential);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == "INVALID_LOGIN_CREDENTIALS") {
                                print("invalid login credentials");
                              } else if (e.code == "too-many-requests") {
                                print("login tried so many times");
                              } else if (e.code == "wrong-password") {
                                print("something happed");
                                print(e.code);
                              } else {
                                print(e.code);
                                print(e.runtimeType);
                                print(e.message);
                              }
                            }
                          },
                          child: const Text("Login"))
                    ],
                  );

                default:
                  return const Text("Loading....");

                // TODO: Handle this case.
              }
            }));
  }
}
//9:39