import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utkarsh/services/sharedPrefServices.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth;

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('Users');

  AuthenticationServices(this._firebaseAuth);

  Stream<User?> get authStateChanged => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await clearPrefs();
  }

  //sign in with email and password
  Future signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //register with email and password
  // Future registerWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _firebaseAuth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     User? user = result.user;
  //     return user;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign out
  Future<String> signUp({
  required String name,
  required String email,
  required String number,
  required String password,
}) async {
  try {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = _firebaseAuth.currentUser;
    String? uid = user?.uid;

    await _collectionReference.doc(uid).set({
      'id': uid,
      'name': name,
      'email': email,
      'number': number,
    });

    return "Signed up";
  } on FirebaseAuthException catch (e) {
    // Log or handle the error as needed
    print("Error during sign up: ${e.message}");
    return e.message ?? "An error occurred during sign up";
  }
}


}
