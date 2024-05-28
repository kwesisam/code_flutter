import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pils/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleLogin;
  const SignUp({super.key, required this.toggleLogin});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final _auth = AuthenticationService();
  bool isLoading = false;
  String databseError = '';

  bool toggleVisibility = true;
  void togglePasswordVisibility() {
    setState(() {
      toggleVisibility = !toggleVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.3),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Pils Remainder',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: hospitalNameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 194, 79, 37),
                                      width: 1.5)),
                              isDense: true,
                              labelText: 'Hospital Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Hospital Name is required';
                              }

                              if (value.length < 3) {
                                return 'Hospital Name must be at least 3 characters';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 194, 79, 37),
                                      width: 1.5)),
                              isDense: true,
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 194, 79, 37),
                                      width: 1.5)),
                              labelText: 'Password',
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    togglePasswordVisibility();
                                  },
                                  child: toggleVisibility
                                      ? const Icon(
                                          Icons.visibility_off,
                                          size: 30,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          size: 30,
                                        )),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            obscureText: toggleVisibility,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }

                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 194, 79, 37),
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 55),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              setState(() {
                                databseError = '';
                                isLoading = true;
                              });
                              if (formkey.currentState!.validate()) {
                                print('Validated');
                                dynamic result = await _auth.registerUser(
                                    emailController.text,
                                    passwordController.text,
                                    hospitalNameController.text);
                                if (result != null) {
                                  setState(() {
                                    databseError = result as String;
                                    isLoading = false;
                                  });
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: isLoading
                                ? const Text(
                                    'Loading...',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  )
                                : const Text('Sign Up',
                                    style: TextStyle(
                                        fontSize: 19.0, color: Colors.white)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              databseError,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.toggleLogin();
                            },
                            child: const Text(
                              'Sign In',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 17),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
