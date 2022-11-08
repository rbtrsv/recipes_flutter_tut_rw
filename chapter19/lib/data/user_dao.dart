import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This class extends ChangeNotifier so that you can notify any listeners
// whenever a user has logged in or logged out.
// The auth variable is used to hold on to an instance of FirebaseAuth.
class UserDao extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  // TODO: Add helper methods

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  String? userId() {
    return auth.currentUser?.uid;
  }

  String? email() {
    return auth.currentUser?.email;
  }

  // TODO: Add signup
  // Pass in the email and password the user entered. For a real app, you will
  // need to make sure those strings meet your requirements.
  // Return an error message if needed.
  Future<String?> signup(String email, String password) async {
    try {
      // Call the Firebase method to create a new account.
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Notify all listeners so they can then check when a user is logged in.
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      // Handle some common errors.
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      return e.message;
      // Catch any other type of exception.
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  // TODO: Add login
  Future<String?> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      return e.message;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  // TODO: Add logout
  void logout() async {
    await auth.signOut();
    notifyListeners();
  }
}
