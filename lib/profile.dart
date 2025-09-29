import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/login.dart';
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
            height: MediaQuery.of(context).size.width * 1,
            child: Stack(
              clipBehavior: Clip.none, // prevents clipping
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

                Positioned(
                  top: 350,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width *
                              0.9, // full width
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 40),
                                  Image.asset(
                                    'assets/images/p.png',
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Profile'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 226, 241, 99),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 40),
                                  Image.asset(
                                    'assets/images/f.png',
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Favourite'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 226, 241, 99),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 40),
                                  Image.asset(
                                    'assets/images/pp.png',
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Privacy Policy'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 226, 241, 99),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 40),
                                  Image.asset(
                                    'assets/images/s.png',
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Settings'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 226, 241, 99),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 40),
                                  Image.asset(
                                    'assets/images/h.png',
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Help'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 226, 241, 99),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 40),
                                  Image.asset(
                                    'assets/images/l.png',
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Logout'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 226, 241, 99),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
