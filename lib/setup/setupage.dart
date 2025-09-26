import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/provider/femalemodel.dart';
import 'package:fitbody/provider/malemodel.dart';
import 'package:fitbody/setup/setupweight.dart';
import 'package:flutter/material.dart';
import 'package:numeric_selector/numeric_selector.dart';
import 'package:provider/provider.dart';

class Setup3 extends StatefulWidget {
  const Setup3({super.key});

  @override
  State<Setup3> createState() => _Setup3State();
}

class _Setup3State extends State<Setup3> {
  String? selectedAge;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              'How Old Are You?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 50),

          HorizontalNumericSelector(
            minValue: 13,
            maxValue: 100,
            step: 1,
            initialValue: 20,
            onValueChanged: (value) {
              // setState(() {
              //   selectedAge = value.toString();
              // });
              print("Selected Value: $value");
            },
            viewPort: 0.3,
            selectedTextStyle: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            unselectedTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(124, 0, 0, 0),
            ),
            backgroundColor: Color.fromARGB(255, 179, 160, 255),
            showLabel: true,
            label: "Years Old",
            showArrows: true,
            enableVibration: true,
          ),
          SizedBox(height: 300),
          GestureDetector(
            onTap: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.uid)
                    .set({"age": selectedAge}, SetOptions(merge: true));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Setup4()),
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
