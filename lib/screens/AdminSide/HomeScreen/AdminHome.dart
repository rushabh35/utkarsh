import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:utkarsh/constants/app_constants_colors.dart';
import 'package:utkarsh/utils/ui/CustomButton.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadImages(String documentId) async {
    try{
      final List<XFile>? images = await _picker.pickMultiImage();
          
      if (images != null) {
        for (var image in images) {
          Reference storageReference = FirebaseStorage.instance.ref().child("pickupInfoImages").child("$documentId/${DateTime.now().millisecondsSinceEpoch}");

          UploadTask uploadTask = storageReference.putFile(File(image.path));

          await uploadTask.whenComplete(() async {
            String imageUrl = await storageReference.getDownloadURL();

            // Update Firestore document with the image URL
            await FirebaseFirestore.instance
                .collection('pickupInfo')
                .doc(documentId)
                .update({
              'images': FieldValue.arrayUnion([imageUrl]),
            });
          });
        }
      }
    } catch(error){
      print("Error uploading image: $error");
    }
    
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: AppConstantsColors.whiteColor,
        title: const Text(
          "ADMIN HOME",
          style: TextStyle(
            color: AppConstantsColors.blackColor,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('pickupInfo').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                return Card(
                  margin: const EdgeInsets.all(20),
                  color: AppConstantsColors.blackColor,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
       
       
       
               children: [
                        Text(
                          "Name: ${snapshot.data!.docs[i]['name']}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Location: ${snapshot.data!.docs[i]['location']}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "PhonNumber: ${snapshot.data!.docs[i]['mobile']}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Pickup date: ${snapshot.data!.docs[i]['pickupDate']}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Time: ${snapshot.data!.docs[i]['pickupTime']}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Quantity: ${snapshot.data!.docs[i]['quantity']}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                buttonColor: AppConstantsColors.accentColor,
                                width: sizeWidth * 0.3,
                                height: 30,
                                text: snapshot.data!.docs[i]['order_open'] == true
                                  ? "Pickup Open"
                                  : "Pickup Done",
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('pickupInfo')
                                    .doc(snapshot.data!.docs[i].id)
                                    .update({
                                  'order_open': false,
                                });
                                },
                              ),
                              if(snapshot.data!.docs[i]['order_open'] == false )
                                CustomButton(
                                  buttonColor: AppConstantsColors.accentColor,
                                  width: sizeWidth * 0.5,
                                  height: 30,
                                  text: "Upload Images of Pickup",
                                  onPressed: () {
                                    _uploadImages(snapshot.data!.docs[i].id);
                                  },
                                ),
                            ],
                          ),
                          

                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
