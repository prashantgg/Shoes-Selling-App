import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../login_screen.dart';

class FirebaseAuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future <User?> signUpWithEmailandPassword(String email, String password, String username)async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Set the display name
      if (user != null) {
        await user.updateProfile(displayName: username);
      }

      return user;
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
    return null;
  }
  }
  Future <User?> signInWithEmailandPassword(String email, String password, String )async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }

void signOutUser(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  } catch (e) {
    print("Error signing out: $e");
    // Handle sign-out errors if needed
  }
}