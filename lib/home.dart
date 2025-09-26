import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
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

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
          return Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${userData['nickname'] ?? 'User'}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 137, 108, 254),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "It's time to challenge your limits.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 137, 108, 254),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.notifications,
                        color: Color.fromARGB(255, 137, 108, 254),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 137, 108, 254),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              //////////////RECOMMENDATIONS//////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        'Recommendations',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color.fromARGB(255, 226, 241, 99),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'See All',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Color.fromARGB(255, 226, 241, 99),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 35, 35, 35),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/images/r1.png'),
                        Positioned(
                          top: 75,
                          right: 10,
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Color.fromARGB(255, 137, 108, 254),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(
                            Icons.star_rounded,
                            color: Color.fromARGB(255, 226, 241, 99),
                          ),
                        ),
                        Positioned(
                          bottom: 35,
                          left: 10,
                          child: Text(
                            'Squat Exercise',
                            style: TextStyle(
                              color: Color.fromARGB(255, 226, 241, 99),
                              fontSize: 12,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 20,

                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              Icon(
                                Icons.timer,
                                size: 15,
                                color: Color.fromARGB(255, 137, 108, 254),
                              ),
                              Text(
                                '12 Minutes',
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.fireplace,
                                size: 15,
                                color: Color.fromARGB(255, 137, 108, 254),
                              ),
                              Text('120 Kcal', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 35, 35, 35),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Stack(
                      //  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/r2.png'),
                        Positioned(
                          top: 75,
                          right: 10,
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Color.fromARGB(255, 137, 108, 254),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(Icons.star_rounded, color: Colors.white),
                        ),
                        Positioned(
                          bottom: 35,
                          left: 10,
                          child: Text(
                            'Full Body Stretching',
                            style: TextStyle(
                              color: Color.fromARGB(255, 226, 241, 99),
                              fontSize: 12,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 20,

                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              Icon(
                                Icons.timer,
                                size: 15,
                                color: Color.fromARGB(255, 137, 108, 254),
                              ),
                              Text(
                                '12 Minutes',
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.fireplace,
                                size: 15,
                                color: Color.fromARGB(255, 137, 108, 254),
                              ),
                              Text('120 Kcal', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //////////////RECOMMENDATIONS END//////////////////
              SizedBox(height: 20),
              ///////////////WEEKLY CHALLENGES//////////////////
              Container(
                height: 150,
                color: Color.fromARGB(255, 179, 160, 255),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 35, 35, 35),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Weekly\n Challenge',
                              style: TextStyle(
                                color: Color.fromARGB(255, 226, 241, 99),
                              ),
                            ),
                            Text(
                              'Plank With Hip Twist',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Container(
                          // height: 150,
                          width: 125,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/wc.png'),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
