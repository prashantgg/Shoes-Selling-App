import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendtrove/login_screen.dart';
import 'dart:io';
import 'AboutPage.dart';
import 'feedback_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values for demonstration purposes
    _nameController.text = 'John Doe';
    _addressController.text = '123 Main St, Cityville';
    _emailController.text = 'john.doe@email.com';
    _phoneNumberController.text = '+1 234 567 890';
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 1, top: 10),
                  child: Container(
                    height: 120,
                    width: 120, // Adjust the width to make it a perfect circle
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: user != null && user.photoURL != null
                          ? ClipOval(
                        child: Image.network(
                          user.photoURL!,
                          width: 250,
                          height: 400,
                          fit: BoxFit.cover, // Adjust the fit property
                        ),
                      )
                          : Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 45.0),
              // User Information Card
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Editable Name
                      Text(
                        user != null && user.displayName != null
                            ? user.displayName!
                            : "Name",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Editable Address

                      SizedBox(height: 8.0),
                      // Editable Email
                      Text(
                        user != null && user.email != null
                            ? user.email!
                            : "Email",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Editable Phone Number
                    ],
                  ),
                ),
              ),
              SizedBox(height: 350.0),

              // Logout Button
              GestureDetector(
                onTap: () {
                  // Navigate to the existing feedback page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red, // Background color for the button
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, size: 30, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
