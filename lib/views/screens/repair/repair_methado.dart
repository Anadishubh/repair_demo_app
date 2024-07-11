import 'package:aci_app/constants/button_constant.dart';
import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepairMethodologyPage extends StatefulWidget {
  const RepairMethodologyPage({super.key});

  @override
  State<RepairMethodologyPage> createState() => _RepairMethodologyPageState();
}

class _RepairMethodologyPageState extends State<RepairMethodologyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Image.asset(
                  Images.logo,
                  height: 40,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'ADHAR CONSULTANCY\nAND INFRACTRUCTURE',
                  style: FontConstant.styleBold(
                      fontSize: 14, color: AppColors.primaryColor),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.share,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Q. What is a shear Crack in RCC ?',
                style: FontConstant.styleSemiBold(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Text(
                'A. It is postulated that various modes of diagonal failure exhibited multiaxial stress conditions load that exits in the pathn along which the comprehensive force is transmitted from support.',
                style: FontConstant.styleMedium(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 15),
              child: Text(
                'Q. What is a shear Crack in RCC ?',
                style: FontConstant.styleSemiBold(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Text(
                'A. It is postulated that various modes of diagonal failure exhibited multiaxial stress conditions load that exits in the pathn along which the comprehensive force is transmitted from support.',
                style: FontConstant.styleMedium(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 15),
              child: Text(
                'Q. What is a shear Crack in RCC ?',
                style: FontConstant.styleSemiBold(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Text(
                'A. It is postulated that various modes of diagonal failure exhibited multiaxial stress conditions load that exits in the pathn along which the comprehensive force is transmitted from support.',
                style: FontConstant.styleMedium(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            SizedBox(height: 30,),
            CustomShadowButton(
              text: 'Book Appointment',
              onPressed: () {},
              color: AppColors.primaryColor,
              textStyle:
                  FontConstant.styleSemiBold(fontSize: 18, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
