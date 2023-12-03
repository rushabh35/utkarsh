import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:utkarsh/services/auth.dart';
import 'screens/LandingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    Provider<AuthenticationServices>(
      create: (context) => AuthenticationServices(FirebaseAuth.instance),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
        //   textTheme: const TextTheme(
        //     subtitle1: TextStyle(color: Colors.black), //<-- SEE HERE
        //   ),
        //   inputDecorationTheme: InputDecorationTheme(
        //     hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
        //     contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //     border: const OutlineInputBorder(borderSide: BorderSide.none),
        //   ),
        // ),
        home: LandingPage()
        // // const LoginScreen()
        //   LoginScreen()

        );
  }
}
