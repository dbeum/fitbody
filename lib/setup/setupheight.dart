import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/provider/gendermodel.dart';

import 'package:fitbody/setup/setupweight.dart';
import 'package:fitbody/setup/setupgoal.dart';
import 'package:flutter/material.dart';
import 'package:numeric_selector/numeric_selector.dart';
import 'package:provider/provider.dart';

class Setup5 extends StatefulWidget {
  const Setup5({super.key});

  @override
  State<Setup5> createState() => _Setup5State();
}

class _Setup5State extends State<Setup5> {
  String? selectedHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              'What is Your Height?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 50),

          VerticalNumericSelector(
            minValue: 50,
            maxValue: 250,
            height: 400,
            step: 1,
            initialValue: 55,
            onValueChanged: (value) {
              print("Selected Value: $value");
            },
            viewPort: 0.25,
            selectedTextStyle: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            unselectedTextStyle: TextStyle(fontSize: 24, color: Colors.grey),
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            showLabel: true,
            label: "cm",
            showArrows: true,
            enableVibration: true,
          ),
          SizedBox(height: 100),
          GestureDetector(
            onTap: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.uid)
                    .set({"height": selectedHeight}, SetOptions(merge: true));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Setup6()),
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
