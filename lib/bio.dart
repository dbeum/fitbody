import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitbody/cloudinary.dart';
import 'package:fitbody/firebase_options.dart';
import 'package:fitbody/setup.dart';
import 'package:fitbody/register.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Bio extends StatefulWidget {
  const Bio({super.key});

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  late final TextEditingController _fullname;
  late final TextEditingController _nickname;
  bool _obscureText = true;
  String? imageUrl;

  final picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    _fullname = TextEditingController();
    _nickname = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fullname.dispose();
    _nickname.dispose();
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

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;
    CloudinaryService cloudinaryService = CloudinaryService();
    imageUrl = await cloudinaryService.uploadImage(_image!);

    // You can now save this URL in your database (Firebase, etc.)
    print('Image uploaded successfully: $imageUrl');
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
                      'Fill Your Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: _pickImage,
                      child: _image != null
                          ? Image.file(_image!, width: 100, height: 100)
                          : Icon(Icons.image, size: 100),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: _uploadImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        "Upload",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10),

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
                                controller: _fullname,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  hintText: 'Enter your Full name',
                                  labelText: 'Full name',
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
                                controller: _nickname,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Enter your Nickname',
                                  labelText: 'Nickname',
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

                              SizedBox(height: 20),

                              Container(
                                height: 36,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 226, 241, 99),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    if (user != null) {
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(user.uid)
                                          .set({
                                            "fullname": _fullname.text,
                                            "nickname": _nickname.text,
                                            "profileImage": imageUrl ?? '',
                                          }, SetOptions(merge: true));
                                    }
                                  },
                                  child: Text(
                                    'Start',
                                    style: TextStyle(color: Colors.black),
                                  ),
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
