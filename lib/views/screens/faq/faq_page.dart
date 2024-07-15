import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/button_constant.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.055,
          vertical: MediaQuery.of(context).size.height * 0.09,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offAndToNamed('/dash');
                  },
                  child: const Icon(
                    CupertinoIcons.back,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
                  Images.logo,
                  height: 40,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'ADHAR CONSULTANCY\nAND INFRASTRUCTURE',
                  style: FontConstant.styleBold(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // Implement share functionality
                  },
                  child: const Icon(
                    Icons.share,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            _buildFAQ('Q. What is a shear Crack in RCC ?',
                'A. It is postulated that various modes of diagonal failure exhibited multiaxial stress conditions load that exits in the path along which the comprehensive force is transmitted from support.'),
            const SizedBox(height: 15),
            _buildFAQ('Q. What is a shear Crack in RCC ?',
                'A. It is postulated that various modes of diagonal failure exhibited multiaxial stress conditions load that exits in the path along which the comprehensive force is transmitted from support.'),
            const SizedBox(height: 15),
            _buildFAQ('Q. What is a shear Crack in RCC ?',
                'A. It is postulated that various modes of diagonal failure exhibited multiaxial stress conditions load that exits in the path along which the comprehensive force is transmitted from support.'),
            const SizedBox(height: 30),
            CustomShadowButton(
              text: 'Book Appointment',
              onPressed: () {
                // Implement appointment booking logic
              },
              color: AppColors.primaryColor,
              textStyle: FontConstant.styleSemiBold(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: FontConstant.styleSemiBold(
            fontSize: 14,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          answer,
          style: FontConstant.styleMedium(
            fontSize: 14,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
