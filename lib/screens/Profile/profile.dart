// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utkarsh/models/userModel.dart';
import 'package:utkarsh/repository/UserRepository.dart';
import 'package:utkarsh/utils/ui/CustomButton.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_constants_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  final String? loggedInEmail;

  const ProfileScreen(
      {Key? key,
      required this.loggedInEmail,})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userRepo = Get.put(UserRepository());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Fetch data from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        // Extract data from the snapshot
        Map<String, dynamic> userData = snapshot.data()!;
        String name = userData['name'];
        String phoneNumber = userData['number'];

        // Set the fetched data in the text controllers
        nameController.text = name;
        phoneController.text = phoneNumber;
      }
    }
  }

  Widget build(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(text: widget.loggedInEmail);
    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            sizeHeight * 0.05), // Set the desired app bar height
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
              color: AppConstantsColors.blackColor,
            ),
          ),
          centerTitle: true,
          elevation: 0, // Remove the app bar shadow
          backgroundColor: Colors.white, // Set the background color
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: sizeHeight * 0.01),

              // SizedBox(height: sizeHeight * 0.05),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: TextField(
                      enabled: false,
                      cursorColor: AppConstantsColors.accentColor,
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstantsColors.accentColor),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: TextField(
                      enabled: false,
                      cursorColor: AppConstantsColors.accentColor,
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstantsColors.accentColor),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: TextField(
                      enabled: false,
                      cursorColor: AppConstantsColors.accentColor,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Number',
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstantsColors.accentColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: sizeHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
