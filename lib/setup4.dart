import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/femalemodel.dart';
import 'package:fitbody/kgmodel.dart';
import 'package:fitbody/lbsmodel.dart';
import 'package:fitbody/malemodel.dart';
import 'package:fitbody/setup5.dart';
import 'package:flutter/material.dart';
import 'package:numeric_selector/numeric_selector.dart';
import 'package:provider/provider.dart';

class Setup4 extends StatefulWidget {
  const Setup4({super.key});

  @override
  State<Setup4> createState() => _Setup4State();
}

class _Setup4State extends State<Setup4> {
  String? selectedWeight;
  @override
  Widget build(BuildContext context) {
    final kgProvider = Provider.of<KgModel>(context);
    final lbsProvider = Provider.of<LbsModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              'What is Your Weight?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  kgProvider.toggleKg();
                  if (kgProvider.kgmodel == true) {
                    lbsProvider.lbsModel = false;
                  }
                },
                child: Container(
                  width: 150,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 226, 241, 99),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Kg',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Container(width: 5, height: 80, color: Colors.black),
              GestureDetector(
                onTap: () {
                  lbsProvider.toggleLbs();
                  if (lbsProvider.lbsModel == true) {
                    kgProvider.kgmodel = false;
                  }
                },
                child: Container(
                  width: 150,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 226, 241, 99),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Lbs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          if (lbsProvider.lbsModel == true)
            HorizontalNumericSelector(
              minValue: 66,
              maxValue: 440,
              step: 1,
              initialValue: 80,
              onValueChanged: (value) {
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
              label: "lbs",
              showArrows: true,
              enableVibration: true,
            ),
          if (kgProvider.kgmodel == true)
            HorizontalNumericSelector(
              minValue: 30,
              maxValue: 200,
              step: 1,
              initialValue: 50,
              onValueChanged: (value) {
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
              label: "Kg",
              showArrows: true,
              enableVibration: true,
            ),
          if (kgProvider.kgmodel == false && lbsProvider.lbsModel == false)
            HorizontalNumericSelector(
              minValue: 30,
              maxValue: 200,
              step: 1,
              initialValue: 50,
              onValueChanged: (value) {
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
              label: "Kg",
              showArrows: true,
              enableVibration: true,
            ),
          SizedBox(height: 200),
          GestureDetector(
            onTap: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.uid)
                    .set({"weight": selectedWeight}, SetOptions(merge: true));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Setup5()),
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
