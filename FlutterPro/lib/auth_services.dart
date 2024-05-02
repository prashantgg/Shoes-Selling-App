import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trendtrove/home_screen.dart';


final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

signInWithGoogle(context)async{

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  _googleSignIn.signOut();
  try{
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if(googleSignInAccount != null){
      final GoogleSignInAuthentication googleSignInAuthentication = await
      googleSignInAccount.authentication;


      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,

      );

      var login = await _firebaseAuth.signInWithCredential(credential);
      print("Firebase Sign-In Result: ${login.toString()}");
      if(login.user != null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    }

  }
  catch (e) {
    print("Error during Google Sign-In: $e");
  }

}