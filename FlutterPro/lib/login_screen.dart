import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trendtrove/auth_services.dart';
import 'package:trendtrove/home_screen.dart';
import 'package:trendtrove/pages/admin.dart';
import 'package:trendtrove/pages/firebase_auth_implemenatation/firebase_auth_services.dart';
import 'package:trendtrove/pages/shop_page.dart';
import 'package:trendtrove/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
TextStyle myStyle = TextStyle(fontSize: 25);
class _LoginScreenState extends State<LoginScreen> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  late String email;
  late String password;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailnameField = TextField(
      controller: _emailController,
      onChanged: (val) {
        setState(() {
          email = val;
        });
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );


    final passwordField = TextField(
      controller: _passwordController,
      onChanged: (val) {
        setState(() {
          password = val;
        });
      },
      obscureText: true,
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );

    final mySigninButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.deepPurple,
        child: MaterialButton(
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.all(20),
          onPressed: () {
            loginScreen();
          },
          child: Text(
            'Login', style: TextStyle(color: Colors.white, fontSize: 25),),
        )
    );
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/tredfin.jpg',
                      width: 500,
                      height: 50,
                    ),

                    Image.asset(
                      'assets/images/tt.jpg',
                      width: 400,
                      height: 300,
                    ),


                    SizedBox(height: 10),
                    // Add space between images
                    Text(
                      'Log In Now',
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    // Add space between text and additional text
                    Text(
                      'Please Log in to continue using our app',
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    emailnameField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20,),
                    mySigninButton,
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        // Add your login with Google logic here
                        // For example, you might want to call a function to handle the Google login.
                        signInWithGoogle(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.google),
                          SizedBox(width: 20),
                          Text(
                            "Login with Google",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),
                    Text(
                      "Don't Have Account?",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.green, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void loginScreen() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Successful sign-in

        // Check for admin credentials
        if (email == "admin@gmail.com") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Admin Login Successful"),
                content: Text("You are now logged in as an admin."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPage()));
        } else {
          // User login successful
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("User Login Successful"),
                content: Text("You are now logged in."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      }
    } catch (e) {
      // Unsuccessful sign-in
      print("Error Occurred: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Wrong email or password. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }}
