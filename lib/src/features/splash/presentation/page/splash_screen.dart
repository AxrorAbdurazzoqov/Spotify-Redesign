import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/features/navbar/presentation/page/navbar.dart';
import 'package:spotify/src/features/onboarding/presentation/page/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => FirebaseAuth.instance.currentUser != null ? const Navbar() : const OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.instance.black,
      body: Center(
        child: ZoomIn(
          delay: const Duration(seconds: 3),
          child: SvgPicture.asset(AppVectors.instance.spotifyLogo),
        ),
      ),
    );
  }
}
