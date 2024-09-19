import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/extensions/show_custom_snack_bar.dart';
import 'package:spotify/src/features/navbar/presentation/page/navbar.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService.init();
  static FirebaseService get instance => _instance;
  FirebaseService.init();

  Future<void> signInWithGoogle({required VoidCallback onSuccess, required VoidCallback onError}) async {
    try {
      await GoogleSignIn().disconnect();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential).whenComplete(onSuccess);
    } catch (e) {
      onError;
    }
  }

  Future<void> signInAsGuest({required VoidCallback onSuccess, required VoidCallback onError}) async {
    try {
      await FirebaseAuth.instance.signInAnonymously().whenComplete(onSuccess);
    } catch (e) {
      onError;
    }
  }

  Future<void> createAccountWithEmail({required String email, required String password, required String username, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Navbar()), (_) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password' && context.mounted) {
        context.showCustomSnackBar(color: ColorConst.instance.green, title: 'Weak password');
      } else if (e.code == 'email-already-in-use' && context.mounted) {
        context.showCustomSnackBar(color: ColorConst.instance.blue, title: 'Email already exists');
      }
    } catch (e) {
      if (context.mounted) {
        context.showCustomSnackBar(color: ColorConst.instance.red, title: 'Something went wrong');
      }
    }
  }

  Future<void> signInWithEmail({required String email, required String password, required VoidCallback onSuccess, required VoidCallback onError}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      onSuccess;
    } catch (e) {
      onError;
    }
  }
}
