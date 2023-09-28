import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/routes.dart'; // Import the Get package

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for a few seconds before navigating to "login"
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pop(context);
      Get.toNamed(Routes.login); // Navigate to the "login" route
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child:
                Lottie.asset(fit: BoxFit.fill, 'assets/resq_animation.json')),
      ),
    );
  }
}
