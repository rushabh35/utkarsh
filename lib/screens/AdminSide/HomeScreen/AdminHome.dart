// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utkarsh/constants/app_constants_colors.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
          color: Colors.black,
        ),
          backgroundColor: AppConstantsColors.whiteColor,
          title: const Text("ADMIN HOME",
            style: TextStyle(
              color: AppConstantsColors.blackColor,
            )
          ),
        ),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('pickupInfo').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.all(20),
                    color: AppConstantsColors.appRedColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Name: " + snapshot.data!.docs[i]['name']),
                      Text("Location: " + snapshot.data!.docs[i]['location']),
                      Text("PhonNumber: " + snapshot.data!.docs[i]['mobile']),
                      Text("Pickup date: " + snapshot.data!.docs[i]['pickupDate']),
                      Text("Time: " + snapshot.data!.docs[i]['pickupTime']),
                      Text("Quantity: " + snapshot.data!.docs[i]['quantity']),
                      if(snapshot.data!.docs[i]['order_open'] == true)
                        Text("Collection Pending"),
                    ]),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
