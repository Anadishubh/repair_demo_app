import 'package:aci_app/constants/button_constant.dart';
import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/constants/textfield_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/images.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.055),
                child: ClipOval(
                  child: Container(
                    width: screenWidth * 0.4,
                    height: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(screenWidth * 0.2),
                      image: const DecorationImage(
                        image: AssetImage(Images.logo),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Text(
              'Signup',
              style: FontConstant.styleMedium(
                fontSize: screenWidth * 0.08,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  const CustomTextField(
                    labelText: 'Name',
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  const CustomTextField(
                    labelText: 'Your Email',
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  const CustomTextField(
                    labelText: 'Password',
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: CustomButton(
                text: 'Sign Up',
                onPressed: () {
                  Get.offAndToNamed('/dash');
                },
                color: AppColors.primaryColor,
                textStyle: FontConstant.styleRegular(
                  fontSize: screenWidth * 0.06,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already a User?',
                  style: FontConstant.styleRegular(
                    fontSize: screenWidth * 0.045,
                    color: AppColors.primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/login');
                  },
                  child: Text(
                    ' Login',
                    style: FontConstant.styleBold(
                      fontSize: screenWidth * 0.05,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    Images.google,
                    height: screenWidth * 0.08,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    Images.facebook,
                    height: screenWidth * 0.08,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    Images.twitter,
                    height: screenWidth * 0.08,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}