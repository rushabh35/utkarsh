import 'package:flutter/material.dart';
import 'package:utkarsh/constants/app_constants_colors.dart';

import '../../widgets/HomeTileWidgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return Scaffold(
      appBar: AppBar(
          clipBehavior: Clip.none,
          backgroundColor: AppConstantsColors.brightWhiteColor,
          leading: const Icon(
            Icons.arrow_back_sharp,
            color: AppConstantsColors.blackColor,
          ),
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
