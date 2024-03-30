import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/login_page.dart';
import 'package:haxplore/features/user_auth/presentation/widgets/form_container_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.red.shade200,
      ),
      backgroundColor: Colors.lightBlue.shade100,

      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to Home Page!", style: TextStyle(fontSize: 50),),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, "/delete");
                },
                child: Container(
                  width: 150,

                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Delete your account",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "/login");
                },
                child: Container(
                  width: 150,

                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: GestureDetector(
                onTap: () async {
                  // Get the current user
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    // Navigate to the BookingPage and pass the current user as an argument
                    Navigator.pushNamed(context, "/booking_page", arguments: user);
                  } else {
                    // Handle the case where the user is not logged in
                    // For example, show a message or navigate to the login page
                    // Navigator.pushNamed(context, "/login");
                    Get.snackbar("Error", "User not logged in");
                  }
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Book Ticket",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

            ),

          ],
        ),
      ),

    );
  }
}