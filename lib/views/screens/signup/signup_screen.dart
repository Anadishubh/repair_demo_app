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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: ClipOval(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadiusDirectional.circular(20),
                      image: const DecorationImage(
                          image: AssetImage(Images.logo), fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 29,
            ),
            Text(
              'SIgnup',
              style: FontConstant.styleMedium(
                  fontSize: 31, color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CustomTextField(
                    labelText: 'Your User ID',
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    labelText: 'Your Email',
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    labelText: 'Password',
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomButton(
                text: 'SIgn Up',
                onPressed: () {
                  Get.offAndToNamed('/dash');
                },
                color: AppColors.primaryColor,
                textStyle:
                    FontConstant.styleRegular(fontSize: 22, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already a User ?',
                  style: FontConstant.styleRegular(
                      fontSize: 16, color: AppColors.primaryColor),
                ),
                Text(
                  ' Login',
                  style: FontConstant.styleBold(
                      fontSize: 18, color: AppColors.primaryColor),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(Images.google,height: 30,),
                ),
                const SizedBox(width: 5,),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(Images.facebook,height:30,),
                ),
                const SizedBox(width: 5,),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(Images.twitter,height: 30,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
