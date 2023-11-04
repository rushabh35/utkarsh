
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:utkarsh/screens/Authentications/NGOSignIn.dart';
import 'package:utkarsh/widgets/UploadImage.dart';
import '../../../../utils/ui/ClickableText.dart';
import '../../../../utils/ui/CustomButton.dart';
import '../../../../utils/ui/CustomTextWidget.dart';
import '../../../../widgets/PasswordTextField.dart';
import '../../constants/app_constants_colors.dart';
import '../../utils/ui/CustomBoldText.dart';
import '../../widgets/LoginTextField.dart';
import 'UsersSignIn.dart';
class NGOSignUp extends StatefulWidget {
  const NGOSignUp({Key? key}) : super(key: key);

  @override
  State<NGOSignUp> createState() => _NGOSignUpState();

}

class _NGOSignUpState extends State<NGOSignUp> {
  //late File _profileImage; // Store the selected profile image file
  final TextEditingController _passWordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  bool _isNotValid = false;

  @override
  Widget build(BuildContext context) {



    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.05), // Set the desired app bar height
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          title: const Text('Profile',

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
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(height: sizeHeight * 0.2),
            CustomBoldText(
              text: 'NGO Create Account',
              fontSize: sizeHeight * 0.05,
              textColor: AppConstantsColors.accentColor,
            ),

            LoginTextFieldWidget(controller: _nameController,               hintText: 'NGO Name',
              errorText : _isNotValid ? "Enter Name Field" : null,),

            LoginTextFieldWidget(
              controller: _emailController,
              hintText: 'NGO Email',
              errorText : _isNotValid ? "Enter Email Field" : null,
            ),
            LoginTextFieldWidget(controller: _numberController, hintText: 'PhoneNumber', keyboardType: TextInputType.number,
              errorText : _isNotValid ? "Enter Number Field" : null,
            ),
            PasswordTextField(controller: _passWordController, hintText: 'Password',
              errorText:  _isNotValid ? "Enter Password Field" : null,
            ),
            // ImageUploadWidget(),


            CustomButton(
              buttonColor: AppConstantsColors.accentColor,
              text: 'SIGN UP',
              onPressed: ()=> {
                // registerUser(),
                // try {
                //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LandingPage()));
                // } catch (e) {
                //   print("Navigation error: $e");
                // }
              },
              width: sizeWidth * 0.92,
              height: sizeHeight * 0.06,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: sizeWidth * 0.25,
                  height: 1, // Adjust the height as needed
                  color: AppConstantsColors.grey, // Set the color here
                ),
                const CustomTextWidget(
                  text: 'Or continue with',
                  textColor: AppConstantsColors.grey,
                ),
                Container(
                  width: sizeWidth * 0.25,
                  height: 1, // Adjust the height as needed
                  color: AppConstantsColors.grey, // Set the color here
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextWidget(
                  text: 'Already have an account? ',
                  textColor: AppConstantsColors.blackColor,
                ),
                ClickableText(
                  text : 'NGO Sign In',
                  textColor : AppConstantsColors.redColor,
                  fontSize : 14,
                  onPressed: () {
                    Navigator
                        .of(context).push(MaterialPageRoute(
                        builder: (context) => const NGOSignIn()));
                  },
                )
              ],
            )



          ],
        ),
      ),
    );
  }
}
