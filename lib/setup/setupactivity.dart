import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/provider/amodel.dart';
import 'package:fitbody/provider/bModel.dart';
import 'package:fitbody/provider/imodel.dart';
import 'package:fitbody/setup/bio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setup7 extends StatefulWidget {
  const Setup7({super.key});

  @override
  State<Setup7> createState() => _Setup7State();
}

class _Setup7State extends State<Setup7> {
  Widget build(BuildContext context) {
    final aProvider = Provider.of<Amodel>(context);
    final bProvider = Provider.of<Bmodel>(context);
    final iProvider = Provider.of<Imodel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              'Physical Activity Level',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 100),

          GestureDetector(
            onTap: () {
              bProvider.togglebmode();
              if (bProvider.bmodel == true) {
                iProvider.imodel = false;
                aProvider.amodel = false;
              }
            },
            child: Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: bProvider.bmodel
                    ? Color.fromARGB(255, 226, 241, 99)
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Center(
                child: Text(
                  'Beginner',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: bProvider.bmodel
                        ? Colors.white
                        : Color.fromARGB(255, 179, 160, 255),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              iProvider.toggleimode();
              if (iProvider.imodel == true) {
                bProvider.bmodel = false;
                aProvider.amodel = false;
              }
            },
            child: Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: iProvider.imodel
                    ? Color.fromARGB(255, 226, 241, 99)
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Center(
                child: Text(
                  'Intermediate',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: iProvider.imodel
                        ? Colors.white
                        : Color.fromARGB(255, 179, 160, 255),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              aProvider.toggleamode();
              if (aProvider.amodel == true) {
                bProvider.bmodel = false;
                iProvider.imodel = false;
              }
            },
            child: Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: aProvider.amodel
                    ? Color.fromARGB(255, 226, 241, 99)
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Center(
                child: Text(
                  'Advance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: aProvider.amodel
                        ? Colors.white
                        : Color.fromARGB(255, 179, 160, 255),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 250),
          if (bProvider.bmodel == true ||
              iProvider.imodel == true ||
              aProvider.amodel == true)
            GestureDetector(
              onTap: () async {
                // final user = FirebaseAuth.instance.currentUser;
                // if (user != null) {
                //   await FirebaseFirestore.instance
                //       .collection("users")
                //       .doc(user.uid)
                //       .set({"gender": selectedGender}, SetOptions(merge: true));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Bio()),
                );
                //   }
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
