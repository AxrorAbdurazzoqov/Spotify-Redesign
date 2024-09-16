import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/extensions/show_custom_snack_bar.dart';
import 'package:spotify/src/features/navbar/presentation/page/navbar.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService.init();
  static FirebaseService get instance => _instance;
  FirebaseService.init();

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Navbar()), (_) => false);
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

  Future<void> signInWithEmail({required String email, required String password, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Navbar()), (_) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' && context.mounted) {
        context.showCustomSnackBar(color: ColorConst.instance.red, title: 'No user found for that email.');
      } else if (e.code == 'wrong-password' && context.mounted) {
        context.showCustomSnackBar(color: ColorConst.instance.red, title: 'Wrong password provided for that user.');
      }
    } catch (e) {
      if (context.mounted) {
        context.showCustomSnackBar(color: ColorConst.instance.red, title: 'Something went wrong');
      }
    }
  }
}
