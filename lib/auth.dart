import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/home.dart';
import 'package:fitbody/nav.dart';
import 'package:fitbody/welcome.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // User is logged in
          return Nav();
        } else {
          // User is not logged in
          return Welcome();
        }
      },
    );
  }
}
