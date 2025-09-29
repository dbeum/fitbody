import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/provider/gendermodel.dart';

import 'package:fitbody/setup/setupage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setup2 extends StatefulWidget {
  const Setup2({super.key});

  @override
  State<Setup2> createState() => _Setup2State();
}

class _Setup2State extends State<Setup2> {
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    final genderProvider = Provider.of<GenderModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              'What\'s Your Gender?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 50),

          GestureDetector(
            onTap: () {
              genderProvider.toggleMale();
              if (genderProvider.ismale == true) {
                genderProvider.isfemale = false;
              }
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: genderProvider.ismale
                    ? Color.fromARGB(255, 226, 241, 99)
                    : Color.fromARGB(37, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(360)),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: Center(
                child: Icon(Icons.male, size: 100, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Male',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              genderProvider.toggleFemale();
              if (genderProvider.isfemale == true) {
                genderProvider.ismale = false;
              }
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: genderProvider.isfemale
                    ? Color.fromARGB(255, 226, 241, 99)
                    : Color.fromARGB(37, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(360)),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: Center(
                child: Icon(Icons.female, size: 100, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Female',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 50),
          if (genderProvider.ismale == true || genderProvider.isfemale == true)
            GestureDetector(
              onTap: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .set({"gender": selectedGender}, SetOptions(merge: true));

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Setup3()),
                  );
                }
              },
              child: Container(
                height: 36,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(37, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 1, color: Colors.white),
                ),

                child: Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
