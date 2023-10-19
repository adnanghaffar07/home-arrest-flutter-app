import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:home_arrest/view/onboarding/sign_in/sign_in_screen.dart';

import '../../../constants/image_constants.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF21356A),
      body: AnimationLimiter(
        child: AnimationConfiguration.staggeredList(
          duration: const Duration(milliseconds: 1500),
          position: 3,
          child: ScaleAnimation(
            duration: const Duration(seconds: 2),
            child: FadeInAnimation(
              duration: const Duration(seconds: 2),
              delay: const Duration(milliseconds: 350),
              child: Center(child: Image.asset(ImagesConstants.logo, height: 150, width: 150)),
            ),
          ),
        ),
      ),
    );
  }
}
