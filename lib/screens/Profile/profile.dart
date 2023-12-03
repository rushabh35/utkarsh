// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:utkarsh/models/userModel.dart';
import 'package:utkarsh/repository/UserRepository.dart';
import 'package:utkarsh/utils/ui/CustomButton.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_constants_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class ProfileScreen extends StatefulWidget {
  final String? loggedInEmail;
  final String? name;
  final String? phoneNumber;

  const ProfileScreen({Key? key, required this.loggedInEmail, required this.name, required this.phoneNumber})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userRepo = Get.put(UserRepository());


  void createUser(UserModel user) async {
   await userRepo.createUser(user);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text : widget.name);
    TextEditingController emailController =
        TextEditingController(text: widget.loggedInEmail);
    TextEditingController phoneController = TextEditingController(text : widget.phoneNumber);
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
                      cursorColor: AppConstantsColors.accentColor,
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                        //  enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: AppConstantsColors.accentColor),
                        // ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstantsColors.accentColor),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: TextField(
                      cursorColor: AppConstantsColors.accentColor,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone number',
                        //  enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: AppConstantsColors.accentColor),
                        // ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstantsColors.accentColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: sizeHeight * 0.05),

              // CustomButton(
              //   buttonColor: AppConstantsColors.accentColor,
              //   text: 'Save',
              //   height: sizeHeight * 0.05,
              //   width: sizeWidth * 0.5,
              //   onPressed: () {
              //     final user = UserModel(
              //       name: nameController.text.trim(),
              //       email: emailController.text.trim(),
              //       number: phoneController.text.trim(),
              //     );
              //   },
              // )
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}
