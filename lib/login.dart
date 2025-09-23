import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitbody/firebase_options.dart';
import 'package:fitbody/setup.dart';
import 'package:fitbody/register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obscureText = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void showTopSnackBar(BuildContext context, String message) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        right: 10,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.black87,
            ),

            child: Text(message, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 150),
                    Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 226, 241, 99),
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Sign into your account to continue',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 50),
                    Container(
                      //  height: 300,
                      width: 300,

                      child: FutureBuilder(
                        future: Firebase.initializeApp(
                          options: DefaultFirebaseOptions.currentPlatform,
                        ),

                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              SizedBox(height: 10),
                              TextField(
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  hintText: 'Enter your email',
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 179, 160, 255),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _password,
                                obscureText: _obscureText,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  hintText: 'Enter your password',
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 179, 160, 255),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20),

                              Container(
                                height: 36,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    37,
                                    255,
                                    255,
                                    255,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    final email = _email.text;
                                    final password = _password.text;

                                    try {
                                      final userCredential = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                            email: email,
                                            password: password,
                                          );

                                      if (userCredential.user != null) {
                                        final user = userCredential.user!;

                                        // Fetch user data from Firestore
                                        DocumentSnapshot userDoc =
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(user.uid)
                                                .get();

                                        if (userDoc.exists) {
                                          final data =
                                              userDoc.data()
                                                  as Map<String, dynamic>?;

                                          print('User ID: ${user.uid}');
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Setup(),
                                            ),
                                          );
                                          print('Logged in as: ${user.email}');
                                        } else {
                                          print('User data not found');
                                          showTopSnackBar(
                                            context,
                                            "User Data not Found",
                                          );
                                        }
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'invalid-credential') {
                                        print('Invalid Credentials');
                                        showTopSnackBar(
                                          context,
                                          "Invalid Credentials",
                                        );
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Dont have an account?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Color.fromARGB(
                                          255,
                                          226,
                                          241,
                                          99,
                                        ),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );

                          //default:
                          //return const Text('Loading...');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
