import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/app_constants_colors.dart';
import '../../utils/ui/ClickableText.dart';
import '../../utils/ui/CustomBoldText.dart';
import '../../utils/ui/CustomButton.dart';
import '../../utils/ui/CustomTextWidget.dart';
import '../../widgets/LoginTextField.dart';
import '../../widgets/PasswordTextField.dart';
import '../Home/Navbar.dart';
import 'UserSignUpPage.dart';

class UserSignIn extends StatefulWidget {
  const UserSignIn({Key? key}) : super(key: key);

  @override
  State<UserSignIn> createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();
  bool _isNotValid = false;
  // SharedPreferences? prefs;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(height: sizeHeight * 0.2),
            CustomBoldText(
              text: 'Sign in with password',
              fontSize: sizeHeight * 0.06,
              textColor: AppConstantsColors.accentColor,
            ),

            LoginTextFieldWidget(
              controller: _emailController,
              hintText: 'Email',
              errorText: _isNotValid ? "Enter Email Field" : null,
            ),

            PasswordTextField(
              controller: _passWordController,
              hintText: 'Password',
              errorText: _isNotValid ? "Enter password Field" : null,
            ),

            CustomButton(
              buttonColor: AppConstantsColors.accentColor,
              text: 'SIGN IN',
              onPressed: () {
                // loginUser();
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passWordController.text
                        )
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavBar()),
                  );
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()})");
                });

                try {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BottomNavBar()));
                } catch (e) {
                  print("Navigation error: $e");
                }
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
                    text: 'Dont have an account? ',
                    textColor: AppConstantsColors.blackColor),
                ClickableText(
                  text: 'Sign Up',
                  textColor: AppConstantsColors.redColor,
                  fontSize: 14,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
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
