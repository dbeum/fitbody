import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/exercisemodel.dart';
import 'package:fitbody/exerciseservice.dart';
import 'package:fitbody/provider/activitymodel.dart';
import 'package:fitbody/provider/starmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(scrolledUnderElevation: 0),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>?>(
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
                FutureBuilder<List<ExcerciseModel>>(
                  future: fetchEquipments(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      final posts = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true, // let GridView size itself
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: posts.length,
                        padding: EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final exercise = posts[index];
                          return Container(
                            height: 150,
                            width: 150,

                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 35, 35, 35),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              border: Border.all(width: 1, color: Colors.white),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(exercise.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                      topRight: Radius.circular(14),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Consumer<StarModel>(
                                    builder: (context, sProvider, child) {
                                      return IconButton(
                                        onPressed: () {
                                          sProvider.toggleStar2();
                                        },
                                        icon: Icon(Icons.star_rounded),
                                        color: sProvider.isStar2
                                            ? Color.fromARGB(255, 226, 241, 99)
                                            : Colors.grey,
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 32,
                                  left: 10,
                                  child: Text(
                                    exercise.name,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 226, 241, 99),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 15,

                                  child: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.timer,
                                        size: 15,
                                        color: Color.fromARGB(
                                          255,
                                          137,
                                          108,
                                          254,
                                        ),
                                      ),
                                      Text(
                                        '12 Minutes',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.fireplace,
                                        size: 15,
                                        color: Color.fromARGB(
                                          255,
                                          137,
                                          108,
                                          254,
                                        ),
                                      ),
                                      Text(
                                        '120 Kcal',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text("No data"));
                    }
                  },
                ),

                // //////////////RECOMMENDATIONS END//////////////////
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
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Weekly\nChallenge',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 226, 241, 99),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Plank With Hip Twist',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // height: 150,
                            width: 125,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/wc.png'),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ///////////////WEEKLY CHALLENGES END//////////////////
                SizedBox(height: 20),

                ////EQUIPMENTS///////////////////////////
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      'Got an Equipment?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 226, 241, 99),
                      ),
                    ),
                  ],
                ),
                FutureBuilder<List<ExcerciseModel>>(
                  future: fetchEquipments(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      final posts = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: posts.length,
                        padding: EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final exercise = posts[index];
                          return Container(
                            height: 150,
                            width: 150,

                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 35, 35, 35),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              border: Border.all(width: 1, color: Colors.white),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(exercise.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                      topRight: Radius.circular(14),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Consumer<StarModel>(
                                    builder: (context, sProvider, child) {
                                      return IconButton(
                                        onPressed: () {
                                          sProvider.toggleStar2();
                                        },
                                        icon: Icon(Icons.star_rounded),
                                        color: sProvider.isStar2
                                            ? Color.fromARGB(255, 226, 241, 99)
                                            : Colors.grey,
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 32,
                                  left: 10,
                                  child: Text(
                                    exercise.name,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 226, 241, 99),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 15,

                                  child: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.timer,
                                        size: 15,
                                        color: Color.fromARGB(
                                          255,
                                          137,
                                          108,
                                          254,
                                        ),
                                      ),
                                      Text(
                                        '12 Minutes',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.fireplace,
                                        size: 15,
                                        color: Color.fromARGB(
                                          255,
                                          137,
                                          108,
                                          254,
                                        ),
                                      ),
                                      Text(
                                        '120 Kcal',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text("No data"));
                    }
                  },
                ),
                // ///////////////ARTICLE & TIPS//////////////////
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         SizedBox(width: 20),
                //         Text(
                //           'Articles & Tips',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 18,
                //             color: Color.fromARGB(255, 226, 241, 99),
                //           ),
                //         ),
                //       ],
                //     ),

                //     SizedBox(width: 20),
                //   ],
                // ),

                // SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Column(
                //       children: [
                //         Container(
                //           height: 130,
                //           width: 150,
                //           decoration: BoxDecoration(
                //             color: Color.fromARGB(255, 35, 35, 35),
                //             borderRadius: BorderRadius.all(Radius.circular(15)),
                //             border: Border.all(width: 1, color: Colors.white),
                //             image: DecorationImage(
                //               image: AssetImage('assets/images/a1.png'),
                //             ),
                //           ),
                //           child: Stack(
                //             children: [
                //               Positioned(
                //                 top: 1,
                //                 right: 1,
                //                 child: Consumer<StarModel>(
                //                   builder: (context, sProvider, child) {
                //                     return IconButton(
                //                       onPressed: () {
                //                         sProvider.toggleStar3();
                //                       },
                //                       icon: Icon(Icons.star_rounded),
                //                       color: sProvider.isStar3
                //                           ? Color.fromARGB(255, 226, 241, 99)
                //                           : Colors.white,
                //                     );
                //                   },
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Text('Supplement Guide...'),
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         Container(
                //           height: 130,
                //           width: 150,
                //           decoration: BoxDecoration(
                //             color: Color.fromARGB(255, 35, 35, 35),
                //             borderRadius: BorderRadius.all(Radius.circular(15)),
                //             border: Border.all(width: 1, color: Colors.white),
                //             image: DecorationImage(
                //               image: AssetImage('assets/images/a2.png'),
                //             ),
                //           ),
                //           child: Stack(
                //             children: [
                //               Positioned(
                //                 top: 1,
                //                 right: 1,
                //                 child: Consumer<StarModel>(
                //                   builder: (context, sProvider, child) {
                //                     return IconButton(
                //                       onPressed: () {
                //                         sProvider.toggleStar4();
                //                       },
                //                       icon: Icon(Icons.star_rounded),
                //                       color: sProvider.isStar4
                //                           ? Color.fromARGB(255, 226, 241, 99)
                //                           : Colors.white,
                //                     );
                //                   },
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Text('15 Quick & Effective..'),
                //       ],
                //     ),
                //   ],
                // ),
                ///////////////ARTICLE & TIPS ENDS//////////////////
              ],
            );
          },
        ),
      ),
    );
  }
}
