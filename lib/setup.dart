import 'package:fitbody/setup2.dart';
import 'package:flutter/material.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      body: Column(
        children: [
          Container(child: Image.asset('assets/images/s1.png')),
          SizedBox(height: 50),
          Text(
            'Consistency Is the Key To progress.Don\'t Give Up!',
            style: TextStyle(
              fontSize: 25,
              //     fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 226, 241, 99),
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 170),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Setup2()),
              );
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
