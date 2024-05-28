import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pils_recommendation/Pages/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleLogin;
  const SignIn({super.key, required this.toggleLogin});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = Authentication();
  bool isvisible = false;
  bool isloading = false;
  String databaseError = '';
  void toggleVisibility() {
    setState(() {
      isvisible = !isvisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.3),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Pil Remainder',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: formkey,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 179, 83, 49)),
                                  ),
                                  labelText: 'Email',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }

                                if (!RegExp(
                                        r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: !isvisible,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: toggleVisibility,
                                    icon: Icon(
                                      isvisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 25,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 179, 83, 49)),
                                  ),
                                  labelText: 'Password',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your password'
                                  : null,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown[400],
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 50),
                              ),
                              onPressed: () async {
                                setState(() {
                                  isloading = true;
                                  databaseError = '';
                                });
                                if (formkey.currentState!.validate()) {
                                  print(passwordController.text);
                                  print(emailController.text);
                                  dynamic result = await _auth.logIn(
                                      emailController.text,
                                      passwordController.text);

                                  if (result != null) {
                                    setState(() {
                                      databaseError = result;
                                      isloading = false;
                                    });
                                  }

                                  setState(() {
                                    isloading = false;
                                  });
                                }

                                setState(() {
                                  isloading = false;
                                });
                              },
                              child: Text(isloading ? 'Loading...' : 'Sign In',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                            databaseError.isEmpty
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      databaseError,
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                            TextButton(
                                onPressed: () {
                                  widget.toggleLogin();
                                },
                                child: const Text('Sign Up',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 17)))
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
