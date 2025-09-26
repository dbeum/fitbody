import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/setup/setupgender.dart';
import 'package:fitbody/setup/setupheight.dart';
import 'package:fitbody/setup/setupactivity.dart';
import 'package:flutter/material.dart';

class Setup6 extends StatefulWidget {
  const Setup6({super.key});

  @override
  State<Setup6> createState() => _Setup6State();
}

class _Setup6State extends State<Setup6> {
  bool checkbox = false;
  bool checkbox2 = false;
  bool checkbox3 = false;
  bool checkbox4 = false;
  bool checkbox5 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              'What is Your Goal?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 50),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(37, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: CheckboxListTile(
                  value: checkbox,

                  key: Key('checkbox1'),
                  onChanged: (value) {
                    setState(() {
                      checkbox = value!;
                    });
                  },
                  title: Text(
                    "Lose Weight",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  activeColor: Color.fromARGB(255, 226, 241, 99),
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  tileColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(37, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: CheckboxListTile(
                  value: checkbox2,
                  key: Key('checkbox2'),
                  onChanged: (value) {
                    setState(() {
                      checkbox2 = value!;
                    });
                  },
                  title: Text(
                    "Gain Weight",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  activeColor: Color.fromARGB(255, 226, 241, 99),
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  tileColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(37, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: CheckboxListTile(
                  value: checkbox3,
                  key: Key('checkbox3'),
                  onChanged: (value) {
                    setState(() {
                      checkbox3 = value!;
                    });
                  },
                  title: Text(
                    "Muscle Mass Gain",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  activeColor: Color.fromARGB(255, 226, 241, 99),
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  tileColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(37, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: CheckboxListTile(
                  value: checkbox4,
                  key: Key('checkbox4'),
                  onChanged: (value) {
                    setState(() {
                      checkbox4 = value!;
                    });
                  },
                  title: Text(
                    "Shape Body",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  activeColor: Color.fromARGB(255, 226, 241, 99),
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  tileColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(37, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: CheckboxListTile(
                  value: checkbox5,
                  key: Key('checkbox5'),
                  onChanged: (value) {
                    setState(() {
                      checkbox5 = value!;
                    });
                  },
                  title: Text(
                    "Other",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  activeColor: Color.fromARGB(255, 226, 241, 99),
                  checkColor: Colors.white,

                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  tileColor: Colors.transparent,
                ),
              ),
            ],
          ),

          SizedBox(height: 200),
          GestureDetector(
            onTap: () async {
              // final user = FirebaseAuth.instance.currentUser;
              // if (user != null) {
              //   await FirebaseFirestore.instance
              //       .collection("users")
              //       .doc(user.uid)
              //       .set({"height": selectedHeight}, SetOptions(merge: true));

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Setup7()),
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
                  'Continue',
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
