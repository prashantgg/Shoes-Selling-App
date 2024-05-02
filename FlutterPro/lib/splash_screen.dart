import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendtrove/home_screen.dart';
import 'package:trendtrove/login_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      final User? initialUser = FirebaseAuth.instance.currentUser;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => initialUser != null ? HomeScreen() : LoginScreen(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

        },
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 200), // Add some space at the top
                  child:Image.asset(
                    'assets/images/tredfin.jpg',
                    width: 500,
                    height: 50,
                  ),
                ),
                SizedBox(height: 150), // Add some space between the images
                Image.asset(
                  'assets/images/ttfinal.jpg',
                  width: 500,
                  height: 350,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}