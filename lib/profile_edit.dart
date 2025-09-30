import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbody/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileEdit extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ProfileEdit({super.key, required this.userData});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late TextEditingController nicknameController;
  late TextEditingController weightController;
  late TextEditingController ageController;
  late TextEditingController heightController;

  @override
  void initState() {
    super.initState();

    nicknameController = TextEditingController(
      text: widget.userData['nickname'],
    );
    weightController = TextEditingController(
      text: widget.userData['weight'].toString(),
    );
    ageController = TextEditingController(
      text: widget.userData['age'].toString(),
    );
    heightController = TextEditingController(
      text: widget.userData['height'].toString(),
    );
  }

  @override
  void dispose() {
    nicknameController.dispose();
    weightController.dispose();
    ageController.dispose();
    heightController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'nickname': nicknameController.text.trim(),
      'weight':
          int.tryParse(weightController.text.trim()) ??
          widget.userData['weight'],
      'age': int.tryParse(ageController.text.trim()) ?? widget.userData['age'],
      'height':
          int.tryParse(heightController.text.trim()) ??
          widget.userData['height'],
    });

    Navigator.pop(context, true); // go back and tell previous page to refresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color.fromARGB(255, 179, 160, 255),
        // actions: [
        //   IconButton(icon: const Icon(Icons.save), onPressed: _saveProfile),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            FutureBuilder<Map<String, dynamic>?>(
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
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Nickname',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 137, 108, 254),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: nicknameController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 137, 108, 254),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Age',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 137, 108, 254),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Height',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 137, 108, 254),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 226, 241, 99),
              ),
              onPressed: _saveProfile,
              child: const Text(
                "Update Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
