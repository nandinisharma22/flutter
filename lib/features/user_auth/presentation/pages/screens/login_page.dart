import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/home_page.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/signup_page.dart';
import 'package:haxplore/features/user_auth/presentation/widgets/form_container_widget.dart';

import '../../../firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:haxplore/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/signup_page.dart';
import 'package:haxplore/features/user_auth/presentation/widgets/form_container_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      backgroundColor: Color(0x8BCBFFFF),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            FormContainerWidget(
              controller: _emailController,
              hintText: "Email",
              isPasswordField: false,
            ),
            SizedBox(height: 10),
            FormContainerWidget(
              controller: _passwordController,
              hintText: "Password",
              isPasswordField: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: Text("Login"),
            ),
            SizedBox(height: 10),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      User? user = await _auth.signInWithEmailandPassword(email, password);

      if (user == null) {
        setState(() {
          _errorMessage = "User ID does not exist.";
        });
      } else {
        print("User signed in successfully");

        // Check the email to determine the redirection
        if (email == 'haxplore672@gmail.com') {
          Navigator.pushReplacementNamed(context, "/admin");
        } else {
          Navigator.pushReplacementNamed(context, "/home");
        }
      }
    } catch (error) {
      setState(() {
        if (error is FirebaseAuthException) {
          if (error.code == "user-not-found") {
            _errorMessage = "User with this email does not exist.";
          } else {
            _errorMessage = _mapFirebaseErrorToMessage(error.code);
          }
        } else {
          _errorMessage = "An error occurred: $error";
        }
      });
      print("An error occurred: $error");
    }
  }


  // Map Firebase error codes to user-friendly messages
  String _mapFirebaseErrorToMessage(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        return "Email does not exist in the database. Please check your email.";
      case "wrong-password":
        return "Wrong password. Please try again.";
      default:
        return "An error occurred: $errorCode";
    }
  }
}
