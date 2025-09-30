import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/login.dart';
import 'package:fitbody/profile_edit.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

Future<Map<String, dynamic>?> getCurrentUserData() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) return null;

  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid) // UID of the logged-in user
        .get();

    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  } catch (e) {
    print("Error: $e");
    return null;
  }
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 179, 160, 255),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getCurrentUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No user data found"));
          }

          final userData = snapshot.data!;
          return Container(
            height: 1000,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  color: Color.fromARGB(255, 179, 160, 255),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: Image.network(
                            "${userData["profileImage"] ?? 'assets/images/logo.png'}",
                          ),
                        ),
                      ),
                      Text(
                        "${userData['nickname']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${userData['email']}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 230,
                  left:
                      MediaQuery.of(context).size.width *
                      0.15, // center horizontally
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * .7,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 137, 108, 254),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          ' ${userData['weight']} \n Weight ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(width: 1, height: 50, color: Colors.white),
                        Text(
                          ' ${userData['age']} \n Age ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(width: 1, height: 50, color: Colors.white),
                        Text(
                          ' ${userData['height']} \n Height ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                // Profile
                Positioned(
                  top: 350,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProfileEdit(userData: userData),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/p.png', height: 30),
                              const SizedBox(width: 10),
                              const Text('Profile'),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 226, 241, 99),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Favourite
                Positioned(
                  top: 400,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => Login()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/f.png', height: 30),
                              const SizedBox(width: 10),
                              const Text('Favourite'),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 226, 241, 99),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Privacy
                Positioned(
                  top: 450,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => Login()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/pp.png', height: 30),
                              const SizedBox(width: 10),
                              const Text('Privacy'),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 226, 241, 99),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Settings
                Positioned(
                  top: 500,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => Login()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/s.png', height: 30),
                              const SizedBox(width: 10),
                              const Text('Settings'),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 226, 241, 99),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Logout
                Positioned(
                  top: 550,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Logout Menu",
                        barrierColor: Colors.black.withOpacity(0.5),
                        pageBuilder: (context, anim1, anim2) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Center(
                              child: Material(
                                color: const Color.fromARGB(0, 33, 33, 33),
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Logout',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      TextButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => Login(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          // add action
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        transitionBuilder: (context, anim1, anim2, child) {
                          return FadeTransition(opacity: anim1, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 200),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/l.png', height: 30),
                              const SizedBox(width: 10),
                              const Text('Logout'),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 226, 241, 99),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
