import 'package:firebase_auth/firebase_auth.dart';
import 'package:pils_recommendation/Pages/services/database.dart';
import 'package:pils_recommendation/models/user.dart';

class Authentication {
  UserCurrent? creatUser(User? user) {
    if (user != null) {
      return UserCurrent(uid: user.uid);
    } else {
      return null;
    }
  }

  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  Future<dynamic> registerUser(String email, String password, String firstname,
      String lastname, String id) async {
    //print("trying to register");

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = credential.user;
      await Database().addUser(firstname, lastname, email, id, user!.uid);
      return creatUser(user);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred during signup.';
      if (e.code == 'email-already-in-use') {
        errorMessage =
            'The email address is already in use by another account.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      }

      return errorMessage;
    }
  }

  Future<dynamic> logIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = credential.user;
      return creatUser(user);
    } on FirebaseAuthException catch (e) {
      //print(e.code);
      String errorMessage = 'An error occurred during login.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Wrong credentials';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'No Internet Connection';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Too many attempts please try later';
      }

      return errorMessage;
    }
  }

  Future logOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } catch (e) {
      return null;
    }
  }

  Future deleteAccount() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }
}
