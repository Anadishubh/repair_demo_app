import 'dart:async';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
          () {
        Get.offAndToNamed('/signup');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.rectangle),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.triangle),
                opacity: 5,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Container(
              width: screenWidth * 0.4, // 40% of the screen width
              height: screenWidth * 0.4, // 40% of the screen width
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(screenWidth * 0.2), // Circular shape
              ),
            ),
          ),
          Center(
            child: Container(
              width: screenWidth * 0.25, // 25% of the screen width
              height: screenWidth * 0.25, // 25% of the screen width
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.logo),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}