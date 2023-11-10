
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../utils/ui/ClickableText.dart';
import '../../../../utils/ui/CustomButton.dart';
import '../../../../utils/ui/CustomTextWidget.dart';
import '../../../../widgets/PasswordTextField.dart';
import '../../constants/app_constants_colors.dart';
import '../../utils/ui/CustomBoldText.dart';
import '../../widgets/LoginTextField.dart';
import '../Home/Navbar.dart';
import 'UsersSignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();

}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passWordController = TextEditingController();
  // TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  bool _isNGO = false; // A boolean to determine if the user is an NGO.

  // Function to handle the registration process.
  void _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passWordController.text);
        // After successful registration, you can add custom logic based on the user type.
        // Here, we'll assume you have an 'isNGO' field in the user profile.

        await userCredential.user!.updateDisplayName( _isNGO ? 'NGO' : 'User');

        // You can store additional user data in Firebase Firestore or Realtime Database.

        // Redirect to the dashboard or login page.
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
        // Handle other FirebaseAuthException errors.
      } catch (e) {
        print(e.toString());
      }
    }
  }
  //late File _profileImage; // Store the selected profile image file

  bool _isNotValid = false;

  void dispose() {
    _passWordController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }
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
              text: 'Create Account',
              fontSize: sizeHeight * 0.05,
              textColor: AppConstantsColors.accentColor,
            ),

            // LoginTextFieldWidget(controller: _nameController, hintText: 'Name'),
            LoginTextFieldWidget(
              controller: _emailController,
              hintText: 'Email',
              errorText : _isNotValid ? "Enter Email Field" : null,
            ),
            // LoginTextFieldWidget(controller: _numberController, hintText: 'PhoneNumber', keyboardType: TextInputType.number,
            //   errorText : _isNotValid ? "Enter Number Field" : null,
            // ),
            PasswordTextField(controller: _passWordController, hintText: 'Password',
              errorText:  _isNotValid ? "Enter Password Field" : null,
            ),
            // Row(
            //   children: <Widget>[
            //     Text('Are you an NGO?'),
            //     Checkbox(
            //       value: _isNGO,
            //       onChanged: (bool? value) { // Change the parameter type to bool?
            //         setState(() {
            //           _isNGO = value ?? false; // Use the value with a null check
            //         });
            //       },
            //     ),
            //   ],
            // ),

            CustomButton(
              buttonColor: AppConstantsColors.accentColor,
              text: 'SIGN UP',
              onPressed: ()=> {
                _register(),



              // FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passWordController.text)
              //     .then((value){
              // print("Created New Account");
              // Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => BottomNavBar()),
              // );
              // }).onError((error,stackTrace) {
              // print("Error: ${error.toString()}");
              // })
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
                  text : 'Sign In',
                  textColor : AppConstantsColors.redColor,
                  fontSize : 14,
                  onPressed: () {
                    Navigator
                        .of(context).push(MaterialPageRoute(
                        builder: (context) => const UserSignIn()));
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
