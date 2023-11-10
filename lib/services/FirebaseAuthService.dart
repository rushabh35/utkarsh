// import 'package:firebase_auth/firebase_auth.dart';
//
// class FirebaseAuthService{
// final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   Future<User?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//       final User? user = userCredential.user;
//       return user;
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<User?> createUserWithEmailAndPassword(String email, String password) async {
//     try {
//       final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//       final User? user = userCredential.user;
//       return user;
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
//
//   Stream<User?> get onAuthStateChanged => _firebaseAuth.authStateChanges();
// }