import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/userModel.dart';
import 'cloud_service.dart';

class GoogleAuth {
  GoogleAuth._();

  static GoogleAuth googleAuth = GoogleAuth._();
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signUpUsingGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(authCredential);

        if (userCredential.user != null) {
          UserModel user = UserModel(
              name: userCredential.user!.displayName,
              email: userCredential.user!.email,
              img: userCredential.user!.photoURL,
              phone: userCredential.user!.phoneNumber,
              token: '',
              isOnline: false,
              typing: false,
              timestamp: Timestamp.now(), read: false);

          await CloudFirestoreService.cloudFirestoreService.insertUser(user);
          Get.offAndToNamed('/home');
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error!', 'Sign-in failed: ${e.message}');
    } catch (e) {
      Get.snackbar('Error!', 'An unexpected error occurred: $e');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
