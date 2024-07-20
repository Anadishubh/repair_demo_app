import 'dart:async';
import 'package:aci_app/controller/auth_controller.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:aci_app/views/screens/signup/signup_screen.dart';
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
    _loadTokenAndNavigate();
  }

  Future<void> _loadTokenAndNavigate() async {
    await TokenStorage.loadToken();
    Timer(
      const Duration(seconds: 2),
          () {
        if (Get.find<AuthController>().getAuthToken()!= null) {
          Get.offAndToNamed('/dash');
        } else {
          Get.offAndToNamed('/signup');
        }
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
              width: screenWidth * 0.45,
              height: screenWidth * 0.45,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(screenWidth * 0.25),
              ),
            ),
          ),
          Center(
            child: Container(
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
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