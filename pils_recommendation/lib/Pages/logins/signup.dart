import 'package:flutter/material.dart';
import 'package:pils_recommendation/Pages/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleLogin;
  const SignUp({super.key, required this.toggleLogin});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  bool isvisible = false;
  bool isloading = false;
  String databaseError = '';
  void toggleVisibility() {
    setState(() {
      isvisible = !isvisible;
    });
  }

  final _auth = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.15),
              child: Column(children: [
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
                          controller: firstNameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.5,
                                    color: Color.fromARGB(255, 179, 83, 49)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
                            }

                            if (!RegExp(r'^[a-zA-Z]*$').hasMatch(value)) {
                              return 'Please enter a valid name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: lastNameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.5,
                                    color: Color.fromARGB(255, 179, 83, 49)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your last name';
                            }

                            if (!RegExp(r'^[a-zA-Z]*$').hasMatch(value)) {
                              return 'Please enter a valid name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: idNumberController,
                          decoration: InputDecoration(
                              labelText: 'ID Number',
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.5,
                                    color: Color.fromARGB(255, 179, 83, 49)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your ID number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.5,
                                    color: Color.fromARGB(255, 179, 83, 49)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }

                            if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
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
                              filled: true,
                              fillColor: Colors.white,
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
                                    width: 1.5,
                                    color: Color.fromARGB(255, 179, 83, 49)),
                              ),
                              labelText: 'Password',
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: !isvisible,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
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
                                    width: 1.5,
                                    color: Color.fromARGB(255, 179, 83, 49)),
                              ),
                              labelText: 'Confirm Password',
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please confirm your password';
                            }

                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
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
                              print('Validated');
                              dynamic result = await _auth.registerUser(
                                  emailController.text,
                                  passwordController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                  idNumberController.text);

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
                          child: Text(
                            isloading ? 'Loading...' : 'Sign Up',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
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
                            child: const Text('Sign In',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 17)))
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
