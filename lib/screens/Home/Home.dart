import 'package:flutter/material.dart';
import 'package:utkarsh/constants/app_constants_colors.dart';
import 'package:utkarsh/screens/book%20a%20pickup/BookPickup.dart';

import '../../widgets/HomeTileWidgets.dart';
import '../../widgets/Menubar/MenuBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return Scaffold(
      drawer: Drawer(

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppConstantsColors.accentColor,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Book A Pickup'),
              onTap: () {
                Navigator
                    .of(context).push(MaterialPageRoute(
                    builder: (context) => const BookPickup()
                )
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),

        clipBehavior: Clip.none,
          backgroundColor: AppConstantsColors.whiteColor,
          // leading: const Icon(
          //   Icons.arrow_back_sharp,
          //   color: AppConstantsColors.blackColor,
          // ),
          title:  const Text('Utkarsh',
            style: TextStyle(
              color: AppConstantsColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),

          ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(sizeWidth * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeTileWidgets(
                heading: 'Education',
                  height: sizeHeight * 0.3,
                  width: sizeWidth * 0.75,
                  tileColor: AppConstantsColors.accentColor,
                  tileContent: 'Over 3 Million childrens in India are not able to receive good education.',
                  titlefontSize: 20,
                  headingfontSize: 30,
                  icon: const Icon(
                    Icons.school,
                    color: AppConstantsColors.blackColor,
                    size: 40,
                  ),
              ),


              HomeTileWidgets(
                heading: 'Food',
                height: sizeHeight * 0.3,
                width: sizeWidth * 0.75,
                tileColor: Colors.lightBlue,
                tileContent: 'Over 5 Million childrens sleep empty stomach daily and are malnutirition in India.',
                titlefontSize: 20,
                headingfontSize: 30,
                icon: const Icon(
                  Icons.food_bank,
                  color: AppConstantsColors.blackColor,
                  size: 40,
                ),
              ),


              HomeTileWidgets(
                heading: 'Health',
                height: sizeHeight * 0.3,
                width: sizeWidth * 0.75,
                tileColor: Colors.orangeAccent,
                tileContent: 'Health is a state of physical, mental and social well-being in which disease and infirmity are absent.',
                titlefontSize: 20,
                headingfontSize: 30,
                icon: const Icon(
                  Icons.health_and_safety,
                  color: AppConstantsColors.blackColor,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
